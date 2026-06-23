#!/usr/bin/env bash
#
# parser.sh — Parse Nmap output into structured service data
#

PARSED_PORTS=()
PARSED_SERVICES=()
PARSED_VERSIONS=()

parse_nmap_output() {
    local nmap_file="$1"

    if [[ ! -f "$nmap_file" ]]; then
        log_error "Nmap file not found: ${nmap_file}"
        return 1
    fi

    print_section "Parsing Nmap Output"

    PARSED_PORTS=()
    PARSED_SERVICES=()
    PARSED_VERSIONS=()

    local count=0

    while IFS= read -r line; do
        if [[ "$line" =~ ^([0-9]+/[a-z]+)[[:space:]]+open[[:space:]]+([^ ]+)[[:space:]]+(.*) ]]; then
            local port="${BASH_REMATCH[1]}"
            local service="${BASH_REMATCH[2]}"
            local version
            version=$(echo "${BASH_REMATCH[3]}" | xargs)

            PARSED_PORTS+=("$port")
            PARSED_SERVICES+=("$service")
            PARSED_VERSIONS+=("$version")

            echo -e "    ${GREEN}●${RESET}  ${BOLD}${port}${RESET}  ${service}  ${DIM}${version}${RESET}"
            ((count++)) || true
        fi
    done < "$nmap_file"

    echo

    if [[ $count -eq 0 ]]; then
        log_warn "No open ports found in ${nmap_file}"
        return 1
    fi

    log_success "Discovered ${BOLD}${count}${RESET}${GREEN} open port(s)${RESET}"
    return 0
}
