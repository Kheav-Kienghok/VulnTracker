#!/usr/bin/env bash

# Colors
RED="\033[1;91m"
GREEN="\033[1;92m"
YELLOW="\033[1;93m"
BLUE="\033[1;94m"
RESET="\033[0m"

log_info() {
    echo -e "${GREEN}[INFO] $*${RESET}"
}

log_success() {
    echo -e "${GREEN}[SUCCESS] $*${RESET}"
}

log_warn() {
    echo -e "${YELLOW}[WARN] $*${RESET}"
}

log_error() {
    echo -e "${RED}[ERROR] $*${RESET}"
}
