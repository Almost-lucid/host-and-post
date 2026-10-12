#!/usr/bin/env bash
# Local test for tools/check_slugs.sh: good names pass, bad names fail.
set -euo pipefail
here=$(cd "$(dirname "$0")" && pwd)
tmp=$(mktemp -d); trap 'rm -rf "$tmp"' EXIT
cd "$tmp" && git init -q && git config user.email t@t && git config user.name t
git commit -q --allow-empty -m base && base=$(git rev-parse HEAD)
check() { # name expected
  git checkout -q -B t "$base"; mkdir -p "demos/$1" && echo x > "demos/$1/index.html"
  git add -A && git commit -q -m "$1"
  if bash "$here/check_slugs.sh" "$base" HEAD >/dev/null 2>&1; then got=pass; else got=fail; fi
  [ "$got" = "$2" ] && echo "ok   $1 -> $got" || { echo "FAIL $1 -> $got (want $2)"; exit 1; }
}
check tip-splitter pass
check timer2 pass
check Bad_Name fail
check "has space" fail
check trailing- fail
echo "all slug checks passed"
