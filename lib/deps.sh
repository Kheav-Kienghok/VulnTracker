#!/usr/bin/env bash
#
# deps.sh — Dependency checker for VulnTracker (Ubuntu only)
# Source this file from main.sh:
#   source "$(dirname "${BASH_SOURCE[0]}")/deps.sh"
#   check_dependencies
#
# Checks for required tools (nmap, searchsploit) and, if missing,
# offers to install them via apt or prints manual install instructions.

check_dependencies() {
    local missing=()
    command -v nmap >/dev/null 2>&1 || missing+=("nmap")
    command -v searchsploit >/dev/null 2>&1 || missing+=("searchsploit")

    if [ ${#missing[@]} -eq 0 ]; then
        log_success "All required dependencies are installed."
        return 0
    fi

    log_error "Missing required dependencies."
    for pkg in "${missing[@]}"; do
        log_error " - ${pkg}"
    done
    echo

    read -rp "Install missing packages now? (Y/n): " answer

    case "$answer" in
        ""|[Yy]|[Yy][Ee][Ss])
            install_dependencies "${missing[@]}"
            ;;
        *)
            log_warn "Installation cancelled."
            echo
            echo "Run:"
            echo "sudo apt update && sudo apt install -y nmap exploitdb"
            exit 1
            ;;
    esac
}

install_dependencies() {

    if ! command -v apt >/dev/null 2>&1; then
        log_error "apt package manager not found."
        log_error "Only Ubuntu/Debian is currently supported."
        exit 1
    fi

    local packages=()

    for pkg in "$@"; do
        if [[ "$pkg" == "searchsploit" ]]; then
            packages+=("exploitdb")
        else
            packages+=("$pkg")
        fi
    done

    log_info "Updating package list..."
    sudo apt update

    log_info "Installing: ${packages[*]}"
    sudo apt install -y "${packages[@]}"

    if command -v nmap >/dev/null 2>&1 &&
       command -v searchsploit >/dev/null 2>&1; then
        log_success "Dependencies installed successfully."
    else
        log_error "Installation failed."
        exit 1
    fi
}
