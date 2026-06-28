#!/usr/bin/env bash
#
# main.sh — VulnTracker entry point
#

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${SCRIPT_DIR}/lib/banner.sh"
source "${SCRIPT_DIR}/lib/utils.sh"
source "${SCRIPT_DIR}/lib/deps.sh"
source "${SCRIPT_DIR}/lib/validator.sh"
source "${SCRIPT_DIR}/lib/scanner.sh"
source "${SCRIPT_DIR}/lib/parser.sh"
source "${SCRIPT_DIR}/lib/vulnerability.sh"
source "${SCRIPT_DIR}/lib/report.sh"

usage() {
    echo "Usage:"
    echo "  ./main.sh <target>"
    echo "  ./main.sh --sample [nmap-output-file]"
    echo
    echo "Examples:"
    echo "  ./main.sh scanme.nmap.org"
    echo "  ./main.sh 192.168.1.0/24"
    echo "  ./main.sh --sample examples/fake_nmap.txt"
}

main() {
    print_banner

    local nmap_file=""
    local target="${1:-}"

    if [[ -z "$target" || "$target" == "-h" || "$target" == "--help" ]]; then
        usage
        exit 0
    fi

    if [[ "$target" == "--sample" ]]; then
        check_dependencies "searchsploit"
        nmap_file="${2:-examples/fake_nmap.txt}"
        log_info "Starting scan using sample nmap data: ${nmap_file}"
    elif [[ -f "$target" ]]; then
        check_dependencies "searchsploit"
        nmap_file="$target"
        log_info "Starting scan using nmap data: ${nmap_file}"
    else
        check_dependencies
        validate_target "$target"
        echo

        run_nmap_scan "$target" "${SCRIPT_DIR}/output/scans"
        nmap_file="$SCAN_OUTPUT_FILE"
    fi
    echo

    parse_nmap_output "${nmap_file}"
    write_scan_summary "${SCRIPT_DIR}/output"
    echo

    search_vulnerabilities
    echo

    generate_report "${SCRIPT_DIR}/output" > /dev/null
}

main "$@"
