# VulnTracker Architecture

```text
main.sh
  |
  +-- lib/deps.sh           Dependency checks
  +-- lib/validator.sh      IPv4, CIDR, and hostname validation
  +-- lib/scanner.sh        Nmap -sV execution
  +-- lib/parser.sh         Open port/service/version extraction
  +-- lib/vulnerability.sh  Searchsploit lookup
  +-- lib/report.sh         Markdown report generation
```

## Module Responsibilities

| Module | Responsibility |
|--------|----------------|
| `validator.sh` | Reject invalid targets before scanning. |
| `scanner.sh` | Run Nmap service/version detection and save raw output. |
| `parser.sh` | Convert Nmap output into arrays and a `port|service|version` summary. |
| `vulnerability.sh` | Search known exploits for parsed services. |
| `report.sh` | Generate the final Markdown security report. |

## Data Flow

```text
target
  -> validated target
  -> output/scans/nmap_<target>_<timestamp>.txt
  -> PARSED_PORTS, PARSED_SERVICES, PARSED_VERSIONS
  -> VULN_RESULTS
  -> output/vuln_report_<timestamp>.md
```
