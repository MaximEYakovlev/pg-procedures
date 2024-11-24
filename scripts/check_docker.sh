#!/bin/bash
source ./scripts/config.sh
source ./scripts/utils.sh

if ! command -v docker &>/dev/null; then
    error_exit "Docker is not installed. Please install Docker to proceed."
fi

success_message "Docker is installed."
