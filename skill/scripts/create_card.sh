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

if [[ $# -lt 3 ]]; then
  echo "Usage: $(basename "$0") DECK_ID FRONT BACK [POSITION]" >&2
  exit 1
fi

deck_id="$1"
front="$2"
back="$3"
position="${4:-}"

escaped_front="${front//\\/\\\\}"
escaped_front="${escaped_front//\"/\\\"}"
escaped_back="${back//\\/\\\\}"
escaped_back="${escaped_back//\"/\\\"}"

if [[ -n "$position" ]]; then
  payload="{\"card\":{\"front\":\"$escaped_front\",\"back\":\"$escaped_back\",\"position\":$position}}"
else
  payload="{\"card\":{\"front\":\"$escaped_front\",\"back\":\"$escaped_back\"}}"
fi

curl -sS -X POST "$base_url/decks/$deck_id/cards" \
  -H "Authorization: Bearer $api_token" \
  -H "Content-Type: application/json" \
  -d "$payload"
