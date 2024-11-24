#!/bin/bash
source ./scripts/config.sh
source ./scripts/utils.sh

warning_message "Running the project script..."
if ! node index.js; then
    error_exit "Project script execution failed."
fi

success_message "Project script executed successfully."
