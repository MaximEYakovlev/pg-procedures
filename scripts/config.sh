#!/bin/bash

DOCKER_COMPOSE_FILE="docker-compose.yml"
DB_CONTAINER_NAME="postgres"
DB_USER="user"
DB_NAME="demo"
DB_PASSWORD="password"
DUMP_FILE="db/dump.sql"
PROJECT_DIR="$(pwd)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color
