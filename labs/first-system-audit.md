# First System Audit — Ubuntu on WSL2

## Goal
Run the read-only `system-audit.sh` Bash script and interpret the basic system information it reports.

## Environment
- Distribution: Ubuntu 24.04.5 LTS
- Kernel: Linux 6.18.54.1-microsoft-standard-WSL2
- Architecture: x86_64
- Environment: Ubuntu running under Windows Subsystem for Linux 2 (WSL2)

## Observed results
- Uptime at the time of the run: about 9 minutes.
- Memory: 6.6 GiB total, 517 MiB used, 6.1 GiB free, 6.1 GiB available.
- Swap: 2.0 GiB total, 0 B used.
- Root filesystem (/): 1007 GiB total, 1.7 GiB used, 955 GiB available, 1% used.
- The short process list included `systemd-journal`, `systemd`, `systemd-udevd`, and `dbus-daemon`.

## What I learned
- The kernel identifies this environment as WSL2, rather than a native Linux boot.
- Memory, swap, uptime, disk usage, and process listings are snapshots from the moment the script runs.
- A process appearing at the top of a short list is not, by itself, evidence of a security issue.
- This script performs basic system inspection only; it is not a vulnerability scanner or a complete security audit.

## Safety
The script completed and printed: `Audit complete. This script only reads and displays system information.`

## Reproduction
From the repository root, run:

```bash
bash labs/system-audit.sh
```

## Scope and limitations
Results describe this WSL2 environment at the time of execution. Resource values can vary between runs and may depend on WSL configuration. No security conclusion should be drawn from this small set of system metrics alone.
