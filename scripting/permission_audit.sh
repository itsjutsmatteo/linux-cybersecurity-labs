#!/usr/bin/env bash
# Find world-writable paths up to two levels below a target directory.
# Usage: bash scripting/permission_audit.sh [directory]
# Read-only: reports findings without modifying permissions.

set -u

target="${1:-.}"

if [[ ! -d "$target" ]]; then
  printf 'Error: not a directory: %s\n' "$target" >&2
  exit 1
fi

printf 'Target directory: %s\n' "$target"
printf 'Checking world-writable paths (maximum depth: 2)...\n\n'

# -perm -0002 matches paths whose "others" write bit is set.
# Permission findings require context; not every result is a vulnerability.
# Keep find's error messages visible so incomplete scans are not hidden.
if find "$target" -maxdepth 2 -perm -0002 -print; then
  printf '\nAudit completed successfully.\n'
  printf 'No permissions were modified.\n'
else
  status=$?
  printf '\nWarning: audit incomplete; find exited with status %s.\n' "$status" >&2
  printf 'Some paths may not have been accessible. Review the errors above.\n' >&2
  exit 2
fi
