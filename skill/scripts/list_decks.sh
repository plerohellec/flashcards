#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$script_dir/.env"

base_url="${BASE_URL:-http://localhost:3004}"
api_token="${API_TOKEN:-}"

if [[ -z "$api_token" ]]; then
  echo "API_TOKEN is required in skill/scripts/.env" >&2
  exit 1
fi

curl -sS "$base_url/decks" \
  -H "Authorization: Bearer $api_token"
