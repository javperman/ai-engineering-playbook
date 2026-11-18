#!/usr/bin/env bash
# check-no-secrets.sh — small, dependency-free pre-push scanner.
#
# Usage:
#   ./scripts/check-no-secrets.sh [repo-root]
#
# It prints file:line and a category, never the matched value. It scans tracked
# files, so it also catches files that are in .gitignore but still tracked.
# It is a first line of defense, not a proof that the repository is clean.

set -euo pipefail

root="${1:-}"
if [[ -z "$root" ]]; then
  root="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
fi
cd "$root"

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "error: not a git repository: $root" >&2
  exit 2
fi

echo "Scanning tracked files in $root"

patterns=(
  'AIza[0-9A-Za-z_-]{20,}'
  'sk-[A-Za-z0-9]{20,}'
  'gh[pousr]_[A-Za-z0-9]{20,}'
  'xox[baprs]-'
  '-----BEGIN [A-Z ]*PRIVATE KEY'
  'AKIA[0-9A-Z]{16}'
  're_[A-Za-z0-9]{20,}'
  'eyJ[A-Za-z0-9_-]{20,}\.[A-Za-z0-9_-]{10,}'
  '(api[_-]?key|secret|password|passwd|token|client_secret)[[:space:]]*[:=][[:space:]]*["'"'"'][^"'"'"']{12,}'
  '(postgres|postgresql|mysql|mongodb|redis)://[^[:space:]"'"'"']+'
  'Bearer[[:space:]]+[A-Za-z0-9._-]{20,}'
)

exclude=(
  ':(exclude)package-lock.json'
  ':(exclude)**/package-lock.json'
  ':(exclude)**/pnpm-lock.yaml'
  ':(exclude)**/*.lock'
)

hits=0
for pattern in "${patterns[@]}"; do
  matches="$(git grep -I -n -E "$pattern" -- . "${exclude[@]}" 2>/dev/null | cut -d: -f1,2 || true)"
  if [[ -n "$matches" ]]; then
    echo "[secret-like pattern]"
    echo "$matches"
    hits=1
  fi
done

sensitive_names="$(git ls-files | grep -Ei '(^|/)(\.env(\..*)?|\.npmrc|\.pypirc|pip\.conf|credentials.*|.*service[-_]?account.*|.*\.(pem|key|p12|jks|pfx)|id_rsa|id_ed25519|mcp-token|secrets?\.(json|ya?ml|txt)|backup.*\.sql)$' | grep -Ev '(^|/)\.env\.(example|sample|template)$' || true)"
if [[ -n "$sensitive_names" ]]; then
  echo "[sensitive filename]"
  echo "$sensitive_names"
  hits=1
fi

personal_paths="$(git grep -I -n -E '/home/[A-Za-z0-9._-]+|C:\\\\Users\\\\' -- . "${exclude[@]}" 2>/dev/null | cut -d: -f1,2 || true)"
if [[ -n "$personal_paths" ]]; then
  echo "[personal path]"
  echo "$personal_paths"
  hits=1
fi

if [[ "$hits" -ne 0 ]]; then
  echo "FAIL: review the lines above. Values are not printed."
  exit 1
fi

echo "OK: no matches in tracked files."
