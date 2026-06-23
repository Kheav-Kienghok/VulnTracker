# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

VulnTracker is a Bash-based network vulnerability assessment pipeline that automates target scanning with Nmap and vulnerability lookup with Searchsploit (exploitdb). Ubuntu/Debian only (uses apt for dependency installation).

## Running

```bash
# Run with a target
./main.sh <target>

# Run with sample data
./main.sh examples/fake_nmap.txt
```

No build step — pure Bash. No test framework is configured.

## Requirements

- bash
- nmap
- exploitdb (provides `searchsploit`)

`lib/deps.sh` auto-detects missing tools and offers to install them via apt.

## Architecture

Entry point is `main.sh`, which sources modules from `lib/` and runs the pipeline:

**Input → Validation → Nmap Scan → Parsing → Vulnerability Lookup → Report**

### lib/ modules

| File | Purpose |
|------|---------|
| `utils.sh` | Color constants and logging functions (`log_info`, `log_success`, `log_warn`, `log_error`) |
| `banner.sh` | ASCII banner display (`print_banner`) |
| `deps.sh` | Dependency checking and apt-based installation (`check_dependencies`) |
| `validator.sh` | Target validation (IP/CIDR/hostname) — stub |
| `scanner.sh` | Nmap scan execution — stub |
| `parser.sh` | Nmap output parsing — stub |
| `vulnerability.sh` | Searchsploit vulnerability lookup (`scan_vulnerabilities`) — partially implemented |
| `report.sh` | Report generation — stub |

Modules are sourced via `source "${SCRIPT_DIR}/lib/<module>.sh"` in `main.sh`. All scripts use `set -euo pipefail`.

## Conventions

- Shell scripts use `#!/usr/bin/env bash` shebang
- Color output uses ANSI escape codes; logging goes through `utils.sh` functions
- `searchsploit` is the CLI name but the apt package is `exploitdb`
- Output files go in `output/`; example data lives in `examples/`
