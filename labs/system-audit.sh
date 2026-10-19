#!/usr/bin/env bash
# Read-only beginner lab: display a small system overview.
# This script does not change system settings or files.

set -u

section() {
  printf '\n=== %s ===\n' "$1"
}

section "Operating system"
if [ -r /etc/os-release ]; then
  # shellcheck disable=SC1091
  . /etc/os-release
  printf 'Distribution: %s\n' "${PRETTY_NAME:-Unknown}"
else
  printf 'Distribution details unavailable (/etc/os-release not found).\n'
fi
printf 'Kernel: %s\n' "$(uname -sr 2>/dev/null || printf 'Unavailable')"
printf 'Architecture: %s\n' "$(uname -m 2>/dev/null || printf 'Unavailable')"

section "Uptime"
if command -v uptime >/dev/null 2>&1; then
  uptime
else
  printf 'The uptime command is not available.\n'
fi

section "Memory"
if command -v free >/dev/null 2>&1; then
  free -h
elif [ -r /proc/meminfo ]; then
  sed -n '1,5p' /proc/meminfo
else
  printf 'Memory information is unavailable with the available commands.\n'
fi

section "Disk usage"
if command -v df >/dev/null 2>&1; then
  df -h .
else
  printf 'The df command is not available.\n'
fi

section "Top processes (current user view)"
if command -v ps >/dev/null 2>&1; then
  ps -eo pid,comm,%cpu,%mem --sort=-%cpu 2>/dev/null | head -n 6 || ps -eo pid,comm
else
  printf 'The ps command is not available.\n'
fi

printf '\nAudit complete. This script only reads and displays system information.\n'
