#!/bin/bash

# === configuration ===
DOCKER_COMPOSE_FILE="docker-compose.yml"
DB_CONTAINER_NAME="postgres"
DB_USER="user"
DB_NAME="demo"
DB_PASSWORD="password"
DUMP_FILE="db/dump.sql"
PROJECT_DIR="$(pwd)"

# === output colors ===
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # no Color

# === functions ===

# check if docker is installed
check_docker() {
    if ! command -v docker &>/dev/null; then
        echo -e "${RED}Error:${NC} Docker is not installed. Please install Docker to proceed."
        exit 1
    fi
}

# start docker compose containers
start_containers() {
    echo -e "${YELLOW}Starting containers...${NC}"
    docker-compose -f "$DOCKER_COMPOSE_FILE" up -d
    if [ $? -ne 0 ]; then
        echo -e "${RED}Error:${NC} Failed to start containers."
        exit 1
    fi
    echo -e "${GREEN}Containers started successfully.${NC}"
}

# install project dependencies
install_dependencies() {
    echo -e "${YELLOW}Installing dependencies...${NC}"
    if ! npm install; then
        echo -e "${RED}Error:${NC} Failed to install dependencies."
        exit 1
    fi
    echo -e "${GREEN}Dependencies installed successfully.${NC}"
}

# import database dump
import_dump() {
    echo -e "${YELLOW}Importing database dump...${NC}"
    if [ ! -f "$DUMP_FILE" ]; then
        echo -e "${RED}Error:${NC} Dump file $DUMP_FILE not found."
        exit 1
    fi

    echo -e "${YELLOW}Connecting to the database and importing the dump...${NC}"
    docker exec -i "$DB_CONTAINER_NAME" bash -c "PGPASSWORD=$DB_PASSWORD psql -U $DB_USER -d $DB_NAME" <"$DUMP_FILE"

    if [ $? -ne 0 ]; then
        echo -e "${RED}Error:${NC} Failed to import database dump."
        exit 1
    fi

    echo -e "${GREEN}Database dump imported successfully.${NC}"
}

# run the main node.js script
run_project_script() {
    echo -e "${YELLOW}Running the main script...${NC}"
    if ! node index.js; then
        echo -e "${RED}Error:${NC} Script execution failed."
        exit 1
    fi
    echo -e "${GREEN}Script executed successfully.${NC}"
}

# stop and clean up docker compose containers
stop_containers() {
    echo -e "${YELLOW}Stopping containers...${NC}"
    docker-compose -f "$DOCKER_COMPOSE_FILE" down
    if [ $? -ne 0 ]; then
        echo -e "${RED}Error:${NC} Failed to stop containers."
        exit 1
    fi
    echo -e "${GREEN}Containers stopped successfully.${NC}"
}

# === main process ===
echo -e "${YELLOW}Starting automation process...${NC}"

# 1. check if docker is installed
check_docker

# 2. start containers
start_containers

# 3. install dependencies
install_dependencies

# 4. import database dump
import_dump

# 5. run the main script
run_project_script

# 6. stop and clean up containers
stop_containers

echo -e "${GREEN}Automation process completed successfully.${NC}"
