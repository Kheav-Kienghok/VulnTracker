#!/usr/bin/env bash
#
# deps.sh — Dependency checker for VulnTracker (Ubuntu only)
#

REQUIRED_DEPS=("nmap" "searchsploit")

check_dependencies() {
    print_section "Dependency Check"

    local missing=()
    local found=()

    for dep in "${REQUIRED_DEPS[@]}"; do
        if command -v "$dep" >/dev/null 2>&1; then
            found+=("$dep")
        else
            missing+=("$dep")
        fi
    done

    for dep in "${found[@]}"; do
        local version
        if [[ "$dep" == "nmap" ]]; then
            version=$(nmap --version 2>/dev/null | head -1 | sed 's/Nmap version //')
        elif [[ "$dep" == "searchsploit" ]]; then
            version="installed"
        fi
        echo -e "    ${GREEN}●${RESET}  ${BOLD}${dep}${RESET}  ${DIM}${version}${RESET}"
    done

    for dep in "${missing[@]}"; do
        echo -e "    ${RED}○${RESET}  ${BOLD}${dep}${RESET}  ${RED}not found${RESET}"
    done

    echo

    if [[ ${#missing[@]} -eq 0 ]]; then
        log_success "All dependencies satisfied."
        return 0
    fi

    print_divider
    echo
    log_error "${#missing[@]} missing package(s) required to continue."
    echo
    echo -e "    ${YELLOW}?${RESET}  Install missing packages now? ${DIM}[Y/n]${RESET}"
    echo -n "    > "
    read -r answer

    case "$answer" in
        ""|[Yy]|[Yy][Ee][Ss])
            echo
            install_dependencies "${missing[@]}"
            ;;
        *)
            echo
            log_warn "Installation cancelled."
            echo
            echo -e "    ${DIM}Manual install:${RESET}"
            echo -e "    ${WHITE}sudo apt update && sudo apt install -y nmap exploitdb${RESET}"
            echo
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

    echo
    if command -v nmap >/dev/null 2>&1 &&
       command -v searchsploit >/dev/null 2>&1; then
        log_success "All dependencies installed successfully."
    else
        log_error "Installation failed."
        exit 1
    fi
}
