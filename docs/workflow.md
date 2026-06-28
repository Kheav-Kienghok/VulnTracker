# VulnTracker Workflow

```text
Input Target
     |
     v
Target Validation
     |
     v
Nmap Scan (-sV)
     |
     v
Result Parsing
     |
     v
Searchsploit Lookup
     |
     v
Vulnerability Matching
     |
     v
Report Generation
     |
     v
Final Security Report
```

## Scanning Workflow

1. The user provides a target to `main.sh`.
2. `lib/validator.sh` validates the target as an IPv4 address, CIDR range, or hostname.
3. `lib/scanner.sh` runs `nmap -sV` and saves normal Nmap output under `output/scans/`.
4. `lib/parser.sh` extracts open ports, service names, and detected versions.
5. The parsed service list is passed to the vulnerability lookup and report modules.

For demos or offline testing, use existing Nmap output:

```bash
./main.sh --sample examples/fake_nmap.txt
```

## Nmap Integration

Live scans run:

```bash
nmap -sV -oN <output-file> <target>
```

The `-sV` flag enables service and version detection. The `-oN` flag writes a normal text report that the parser can process.
