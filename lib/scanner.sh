#!/usr/bin/env bash
#
# scanner.sh - Run Nmap service/version detection
#

SCAN_OUTPUT_FILE=""

run_nmap_scan() {
    local target="$1"
    local output_dir="${2:-output/scans}"
    local timestamp
    local safe_target

    timestamp=$(date '+%Y-%m-%d_%H-%M-%S')
    safe_target=$(echo "$target" | sed -E 's/[^A-Za-z0-9._-]+/_/g')
    SCAN_OUTPUT_FILE="${output_dir}/nmap_${safe_target}_${timestamp}.txt"

    print_section "Nmap Service Scan"

    mkdir -p "$output_dir"

    log_info "Running: nmap -sV ${target}"
    echo

    if ! nmap -sV -oN "$SCAN_OUTPUT_FILE" "$target"; then
        log_error "Nmap scan failed for target: ${target}"
        return 1
    fi

    echo
    log_success "Nmap output saved to ${BOLD}${SCAN_OUTPUT_FILE}${RESET}"
}
