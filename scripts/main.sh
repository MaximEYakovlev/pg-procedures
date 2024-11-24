#!/bin/bash

# Configuration
source ./scripts/config.sh
source ./scripts/utils.sh

# Main process
echo -e "${YELLOW}Starting automation process...${NC}"

# Check if Docker is installed
./scripts/check_docker.sh

# Start containers
./scripts/start_containers.sh

# Install dependencies
./scripts/install_dependencies.sh

# Import database dump
./scripts/import_dump.sh

# Run the project script
./scripts/run_project_script.sh

# Stop and clean up containers
./scripts/stop_containers.sh

echo -e "${GREEN}Automation process completed successfully.${NC}"
