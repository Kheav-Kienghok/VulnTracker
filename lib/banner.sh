#!/usr/bin/env bash
#
# banner.sh — ASCII art banner for VulnTracker
# Source this file from main.sh:
#   source "$(dirname "${BASH_SOURCE[0]}")/banner.sh"
#   print_banner
#

# Colors (safe to reuse if main.sh doesn't already define them)
BANNER_RED='\033[0;31m'
BANNER_GREEN='\033[0;32m'
BANNER_CYAN='\033[0;36m'
BANNER_YELLOW='\033[1;33m'
BANNER_BOLD='\033[1m'
BANNER_RESET='\033[0m'

print_banner() {
    echo -e "${BANNER_CYAN}"
    cat << "EOF"
         _    __      __    ______                __            
        | |  / /_  __/ /___/_  __/________ ______/ /_____  _____
        | | / / / / / / __ \/ / / ___/ __ `/ ___/ //_/ _ \/ ___/
        | |/ / /_/ / / / / / / / /  / /_/ / /__/ ,< /  __/ /    
        |___/\__,_/_/_/ /_/_/ /_/   \__,_/\___/_/|_|\___/_/     
                                                        
EOF
    echo -e "${BANNER_RESET}"
    echo -e "      ${BANNER_YELLOW}Network Vulnerability Scanner${BANNER_RESET}  ${BANNER_GREEN}|${BANNER_RESET}  Nmap + Searchsploit"
    echo -e "      ${BANNER_BOLD}https://github.com/Kheav-Kienghok/VulnTracker${BANNER_RESET}"
    echo
}
