#!/bin/bash
source ./scripts/config.sh
source ./scripts/utils.sh

warning_message "Installing dependencies..."
if ! npm install; then
    error_exit "Failed to install dependencies."
fi

success_message "Dependencies installed successfully."
