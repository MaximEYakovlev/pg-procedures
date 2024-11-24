#!/bin/bash

error_exit() {
    echo -e "${RED}Error:${NC} $1"
    exit 1
}

success_message() {
    echo -e "${GREEN}$1${NC}"
}

warning_message() {
    echo -e "${YELLOW}$1${NC}"
}
