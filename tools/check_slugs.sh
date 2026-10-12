#!/usr/bin/env bash
# Usage: tools/check_slugs.sh <base> <head>
# Fails if any changed path under demos/ uses a folder name that isn't lowercase, hyphenated ASCII.
set -euo pipefail
fail=0
while IFS= read -r f; do
  case "$f" in
    demos/*/*)
      slug=$(echo "$f" | cut -d/ -f2)
      if ! [[ "$slug" =~ ^[a-z0-9]+(-[a-z0-9]+)*$ ]]; then
        echo "::error file=$f::Demo name '$slug' must be lowercase, hyphenated ASCII (e.g. tip-splitter)."
        fail=1
      fi ;;
  esac
done < <(git diff --name-only --no-renames "$1...$2")
exit $fail
