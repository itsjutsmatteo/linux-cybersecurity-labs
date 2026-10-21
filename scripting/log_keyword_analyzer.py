#!/usr/bin/env python3
"""Count selected keywords in a local log file without printing log contents.

Run with:
  python3 scripting/log_keyword_analyzer.py /path/to/logfile

This is a beginner learning tool, not a full security scanner.
"""

import sys
from pathlib import Path

KEYWORDS = {
    "error": ("error",),
    "warning": ("warning", "warn"),
    "failed": ("failed", "failure"),
    "denied": ("denied", "permission denied"),
}


def main() -> int:
    if len(sys.argv) != 2:
        print(f"Usage: python3 {Path(sys.argv[0]).name} <log-file>")
        return 2

    log_path = Path(sys.argv[1]).expanduser()

    if not log_path.is_file():
        print(f"Error: file not found: {log_path}", file=sys.stderr)
        return 1

    counts = {category: 0 for category in KEYWORDS}
    lines_scanned = 0

    try:
        with log_path.open("r", encoding="utf-8", errors="replace") as log_file:
            for line in log_file:
                lines_scanned += 1
                lowered = line.lower()
                for category, terms in KEYWORDS.items():
                    if any(term in lowered for term in terms):
                        counts[category] += 1
    except OSError as exc:
        print(f"Error reading file: {exc}", file=sys.stderr)
        return 1

    print(f"Keyword summary for: {log_path.name}")
    print(f"Lines scanned: {lines_scanned}")
    for category, count in counts.items():
        print(f"{category:>8}: {count}")

    print("\nCounts are approximate keyword matches, not proof of an attack.")
    print("Log contents were not printed.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
