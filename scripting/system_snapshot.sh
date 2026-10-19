#!/usr/bin/env bash
# Read-only snapshot of basic Linux system information.
# Run with: bash scripting/system_snapshot.sh

set -u

section() {
  printf '\n=== %s ===\n' "$1"
}

section "Operating system"
if command -v hostnamectl >/dev/null 2>&1; then
  hostnamectl 2>/dev/null | sed -n '1,8p'
elif [[ -r /etc/os-release ]]; then
  . /etc/os-release
  printf '%s\n' "${PRETTY_NAME:-Unknown Linux distribution}"
else
  printf '%s\n' "OS information unavailable"
fi

section "Kernel"
uname -srmo

section "Uptime"
uptime 2>/dev/null || printf '%s\n' "Uptime information unavailable"

section "Memory"
if command -v free >/dev/null 2>&1; then
  free -h
else
  printf '%s\n' "'free' command is not installed"
fi

section "Disk usage"
df -h . 2>/dev/null || printf '%s\n' "Disk usage unavailable"

section "Network interfaces"
if command -v ip >/dev/null 2>&1; then
  ip -br addr
else
  printf '%s\n' "'ip' command is not installed"
fi

printf '\nSnapshot complete. No system settings were changed.\n'
