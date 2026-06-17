# VulnTracker
Automated Network Reconnaissance & Vulnerability Assessment Pipeline using Nmap and Searchsploit.

## Overview
ReconFlow automates target validation, network scanning, vulnerability lookup, and report generation using a modular Bash pipeline.

## Features
- Target validation (IP / CIDR / hostname)
- Nmap service scanning
- Result parsing
- Vulnerability lookup via Searchsploit
- Automated report generation

## Structure

```text
lib/              # Core modules
output/           # Scan results & reports
examples/         # Sample outputs
docs/             # Architecture & workflow
main.sh           # Entry point
```

## Usage

```bash
./main.sh <target>
```

Example:

```bash
./main.sh scanme.nmap.org
```

## Requirements
- bash
- nmap
- exploitdb (searchsploit)

## Workflow

```text
Input → Validation → Nmap Scan → Parsing → Vulnerability Lookup → Report
```