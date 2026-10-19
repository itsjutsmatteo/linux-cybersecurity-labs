#!/usr/bin/env bash
# Find world-writable paths up to two levels below a target directory.
# Run with: bash scripting/permission_audit.sh [directory]
# This script only reports paths; it does not change permissions.

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
find "$target" -maxdepth 2 -perm -0002 -print 2>/dev/null

status=$?
if [[ $status -ne 0 ]]; then
  printf 'Note: some paths may not have been readable.\n'
fi

printf '\nAudit finished. No permissions were modified.\n'
