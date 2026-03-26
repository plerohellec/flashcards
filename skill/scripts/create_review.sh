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

if [[ $# -lt 2 ]]; then
  echo "Usage: $(basename "$0") CARD_ID OUTCOME [REVIEWED_AT] [RESPONSE_TIME_MS]" >&2
  exit 1
fi

card_id="$1"
outcome="$2"
reviewed_at="${3:-$(date -u +%Y-%m-%dT%H:%M:%SZ)}"
response_time_ms="${4:-}"

escaped_outcome="${outcome//\\/\\\\}"
escaped_outcome="${escaped_outcome//\"/\\\"}"
escaped_reviewed_at="${reviewed_at//\\/\\\\}"
escaped_reviewed_at="${escaped_reviewed_at//\"/\\\"}"

if [[ -n "$response_time_ms" ]]; then
  payload="{\"card_review\":{\"outcome\":\"$escaped_outcome\",\"reviewed_at\":\"$escaped_reviewed_at\",\"response_time_ms\":$response_time_ms}}"
else
  payload="{\"card_review\":{\"outcome\":\"$escaped_outcome\",\"reviewed_at\":\"$escaped_reviewed_at\"}}"
fi

curl -sS -X POST "$base_url/cards/$card_id/reviews" \
  -H "Authorization: Bearer $api_token" \
  -H "Content-Type: application/json" \
  -d "$payload"
