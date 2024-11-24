#!/bin/bash
source ./scripts/config.sh
source ./scripts/utils.sh

warning_message "Importing database dump..."
if [ ! -f "$DUMP_FILE" ]; then
    error_exit "Dump file $DUMP_FILE not found."
fi

docker exec -i "$DB_CONTAINER_NAME" bash -c "PGPASSWORD=$DB_PASSWORD psql -U $DB_USER -d $DB_NAME" <"$DUMP_FILE"

if [ $? -ne 0 ]; then
    error_exit "Failed to import dump."
fi

success_message "Database dump imported successfully."
