#!/bin/bash
source ./scripts/config.sh
source ./scripts/utils.sh

warning_message "Starting containers..."
docker-compose -f "$DOCKER_COMPOSE_FILE" up -d

if [ $? -ne 0 ]; then
    error_exit "Failed to start containers."
fi

success_message "Containers started successfully."
