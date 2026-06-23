#!/usr/bin/env bash

# Colors
RED="\033[1;91m"
GREEN="\033[1;92m"
YELLOW="\033[1;93m"
BLUE="\033[1;94m"
CYAN="\033[1;96m"
WHITE="\033[1;97m"
DIM="\033[2m"
BOLD="\033[1m"
RESET="\033[0m"

log_info() {
    echo -e "  ${BLUE}[*]${RESET} $*"
}

log_success() {
    echo -e "  ${GREEN}[✔]${RESET} $*"
}

log_warn() {
    echo -e "  ${YELLOW}[!]${RESET} $*"
}

log_error() {
    echo -e "  ${RED}[✘]${RESET} $*"
}

print_section() {
    local title="$1"
    echo
    echo -e "  ${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo -e "  ${WHITE}${BOLD} ${title}${RESET}"
    echo -e "  ${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo
}

print_divider() {
    echo -e "  ${DIM}──────────────────────────────────────────────────${RESET}"
}
