#!/usr/bin/env bash
#
# main.sh — VulnTracker entry point
#

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${SCRIPT_DIR}/lib/banner.sh"
source "${SCRIPT_DIR}/lib/utils.sh"
source "${SCRIPT_DIR}/lib/deps.sh"
source "${SCRIPT_DIR}/lib/parser.sh"
source "${SCRIPT_DIR}/lib/vulnerability.sh"
source "${SCRIPT_DIR}/lib/report.sh"

main() {
    print_banner
    check_dependencies

    local nmap_file="${1:-examples/fake_nmap.txt}"

    log_info "Starting scan using nmap data: ${nmap_file}"
    echo

    parse_nmap_output "${nmap_file}"
    echo

    search_vulnerabilities
    echo

    generate_report "${SCRIPT_DIR}/output" > /dev/null
}

main "$@"
