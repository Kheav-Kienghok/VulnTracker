# VulnTracker

Automated Network Reconnaissance & Vulnerability Assessment Pipeline using Nmap and Searchsploit.

## Overview

VulnTracker automates target validation, network scanning, vulnerability lookup, and report generation using a modular Bash pipeline.

## Features

- Target validation for IPv4 addresses, CIDR ranges, and hostnames
- Nmap service/version scanning with `nmap -sV`
- Result parsing for open ports, service names, and versions
- Vulnerability lookup via Searchsploit
- Automated Markdown report generation

## Structure

```text
lib/              # Core modules
output/           # Scan results and reports
examples/         # Sample outputs
docs/             # Architecture and workflow docs
main.sh           # Entry point
```

## Usage

Run a live scan:

```bash
./main.sh <target>
```

Examples:

```bash
./main.sh scanme.nmap.org
./main.sh 192.168.1.0/24
```

Run with bundled sample Nmap output:

```bash
./main.sh --sample examples/fake_nmap.txt
```

## Requirements

- bash
- nmap
- exploitdb (provides `searchsploit`)

On Ubuntu/Debian:

```bash
sudo apt update
sudo apt install -y nmap exploitdb
```

## Workflow

```text
Input -> Validation -> Nmap Scan -> Parsing -> Vulnerability Lookup -> Report
```

## Scanning

Targets can be IPv4 addresses, CIDR ranges, or hostnames. Live scans use Nmap service/version detection:

```bash
nmap -sV -oN output/scans/nmap_<target>_<timestamp>.txt <target>
```

Parsed services are written to `output/parsed_services.txt` in `port|service|version` format for vulnerability assessment.
