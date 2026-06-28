#!/usr/bin/env bash
#
# validator.sh - Validate scan targets before running Nmap
#

TARGET_TYPE=""

is_valid_ipv4() {
    local ip="$1"
    local IFS=.
    local -a octets

    [[ "$ip" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]] || return 1
    read -r -a octets <<< "$ip"
    [[ ${#octets[@]} -eq 4 ]] || return 1

    for octet in "${octets[@]}"; do
        [[ "$octet" =~ ^[0-9]+$ ]] || return 1
        [[ "$octet" -ge 0 && "$octet" -le 255 ]] || return 1
    done

    return 0
}

is_valid_cidr() {
    local cidr="$1"
    local ip prefix

    [[ "$cidr" == */* ]] || return 1
    ip="${cidr%/*}"
    prefix="${cidr#*/}"

    is_valid_ipv4 "$ip" || return 1
    [[ "$prefix" =~ ^[0-9]+$ ]] || return 1
    [[ "$prefix" -ge 0 && "$prefix" -le 32 ]] || return 1
}

is_valid_hostname() {
    local hostname="$1"

    [[ ${#hostname} -ge 1 && ${#hostname} -le 253 ]] || return 1
    [[ "$hostname" != *..* ]] || return 1
    [[ "$hostname" =~ ^[A-Za-z0-9]([A-Za-z0-9-]{0,61}[A-Za-z0-9])?(\.[A-Za-z0-9]([A-Za-z0-9-]{0,61}[A-Za-z0-9])?)*$ ]] || return 1

    return 0
}

validate_target() {
    local target="$1"

    print_section "Target Validation"

    if [[ -z "$target" ]]; then
        log_error "No target supplied."
        return 1
    fi

    if [[ "$target" =~ [[:space:]] ]]; then
        log_error "Targets cannot contain whitespace: ${target}"
        return 1
    fi

    if is_valid_ipv4 "$target"; then
        TARGET_TYPE="IPv4 address"
    elif is_valid_cidr "$target"; then
        TARGET_TYPE="CIDR range"
    elif [[ "$target" =~ ^[0-9.]+$ ]]; then
        log_error "Invalid IPv4 address or CIDR range: ${target}"
        return 1
    elif is_valid_hostname "$target"; then
        TARGET_TYPE="hostname"
    else
        log_error "Invalid target: ${target}"
        echo
        echo "    Accepted formats:"
        echo "      - IPv4:     192.168.1.10"
        echo "      - CIDR:     192.168.1.0/24"
        echo "      - Hostname: scanme.nmap.org"
        return 1
    fi

    echo -e "    ${GREEN}*${RESET}  ${BOLD}${target}${RESET}  ${DIM}${TARGET_TYPE}${RESET}"
    echo
    log_success "Target accepted."
}
