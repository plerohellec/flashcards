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
  echo "Usage: $(basename "$0") NAME [DESCRIPTION]" >&2
  exit 1
fi

name="$1"
description="${2:-}"

escaped_name="${name//\\/\\\\}"
escaped_name="${escaped_name//\"/\\\"}"
escaped_description="${description//\\/\\\\}"
escaped_description="${escaped_description//\"/\\\"}"

payload="{\"deck\":{\"name\":\"$escaped_name\",\"description\":\"$escaped_description\"}}"

curl -sS -X POST "$base_url/decks" \
  -H "Authorization: Bearer $api_token" \
  -H "Content-Type: application/json" \
  -d "$payload"
