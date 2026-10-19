# Practical Labs

This folder contains small exercises created while learning Linux and cybersecurity fundamentals.

## Lab index

### System audit script
**File:** `system-audit.sh`

A read-only Bash script that reports basic OS/kernel information, uptime, memory and disk usage where supported, and a short process list.

**Run:**
```bash
bash labs/system-audit.sh
```

**What it practices:** command discovery, command substitution, readable terminal output, and basic system inspection.

### Network diagnostics and system logs
**File:** `network-diagnostics-and-system-logs.md`

Covers interface addresses, routing, DNS resolution, ping tests, recent journal entries, error filtering, login history, and a cautious search for failed-authentication messages. The report records only observations confirmed during the exercise and does not invent detailed findings where output was not saved.

**What it practices:** basic connectivity troubleshooting and introductory log analysis in Ubuntu on WSL2.

## Adding a lab

Include the goal, environment, commands, observations, and lessons learned. Only label an exercise as completed after running it and checking the result.
