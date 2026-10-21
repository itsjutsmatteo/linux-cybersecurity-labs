# Scripting

A place for small scripts and notes as I learn Bash and Python.

## Planned learning path

- [ ] Variables and quoting in Bash
- [ ] Exit codes and conditional statements
- [ ] Loops and command-line arguments
- [ ] Functions and reusable code
- [x] Input validation and error handling
- [x] Basic Python scripting

## Starter scripts

### 1. System snapshot (Bash)

Collects basic OS, kernel, uptime, memory, disk, and network-interface information. Read-only.

```bash
bash scripting/system_snapshot.sh
```

### 2. Permission audit (Bash)

Reports world-writable paths up to two directory levels under a target. It does not modify permissions. Findings need context and are not automatically vulnerabilities.

```bash
bash scripting/permission_audit.sh .
bash scripting/permission_audit.sh /tmp
```

If the target is not a directory, the script exits with code 1. If `find` cannot complete the scan, it reports the problem and exits with code 2.

### 3. Log keyword analyzer (Python)

Counts selected keyword-matching lines in a local log file without printing its contents. It also reports how many lines were scanned.

```bash
python3 scripting/log_keyword_analyzer.py /path/to/logfile
```

The summary contains approximate matches for `error`, `warning`, `failed`, and `denied`. A line is counted at most once per category, even if a matching term appears multiple times on that line. These counts are not proof of an attack.

Exit codes:
- `0`: analysis completed.
- `1`: the file is missing or could not be read.
- `2`: incorrect number of command-line arguments.

Use a log file you are allowed to inspect. Some logs require elevated privileges to read; don't publish sensitive log data.

## Conventions

- Prefer clear names and comments where they help explain intent.
- Handle missing commands or files gracefully.
- Avoid destructive actions by default.
- Explain how to run each script and what output to expect.
