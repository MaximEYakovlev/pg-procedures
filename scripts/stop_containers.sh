#!/bin/bash
source ./scripts/config.sh
source ./scripts/utils.sh

warning_message "Stopping containers..."
docker-compose -f "$DOCKER_COMPOSE_FILE" down

if [ $? -ne 0 ]; then
    error_exit "Failed to stop containers."
fi

success_message "Containers stopped successfully."
