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

if [[ $# -lt 1 ]]; then
  echo "Usage: $(basename "$0") DECK_ID" >&2
  exit 1
fi

deck_id="$1"

curl -sS "$base_url/decks/$deck_id/cards" \
  -H "Authorization: Bearer $api_token"
