# Flashcards API

A minimal Rails 8 API for flashcards, backed by SQLite and protected by a single bearer token. The app models three core resources:

- decks
- cards
- card reviews

The API is JSON-only and intentionally small so it is easy to exercise from curl or the helper scripts in `skill/scripts`.

## Requirements

- Ruby 3.4.8
- Rails 8.1.3
- SQLite3

## Setup

Install gems and prepare the database:

```bash
bundle install
bin/rails db:prepare
```

Start the API server:

```bash
bin/rails server
```

Run the test suite:

```bash
bin/rails test
```

## Authentication

Every request except `/up` must include a bearer token:

```bash
Authorization: Bearer flashcards-api-token
```

The app reads the token from `FLASHCARDS_API_TOKEN` and falls back to `flashcards-api-token` if the environment variable is not set.

Example:

```bash
export FLASHCARDS_API_TOKEN=your-real-token
```

## API Overview

### Health

- `GET /up`

### Decks

- `GET /decks`
- `POST /decks`
- `GET /decks/:id`
- `PATCH /decks/:id`
- `DELETE /decks/:id`

Create payload:

```json
{
  "deck": {
    "name": "French Basics",
    "description": "Common vocabulary"
  }
}
```

### Cards

- `GET /decks/:deck_id/cards`
- `POST /decks/:deck_id/cards`
- `GET /cards/:id`
- `PATCH /cards/:id`
- `DELETE /cards/:id`

Create payload:

```json
{
  "card": {
    "front": "Bonjour",
    "back": "Hello",
    "position": 1
  }
}
```

### Card Reviews

- `GET /cards/:card_id/reviews`
- `POST /cards/:card_id/reviews`
- `GET /card_reviews/:id`

Create payload:

```json
{
  "card_review": {
    "outcome": "good",
    "reviewed_at": "2026-03-25T16:53:19Z",
    "response_time_ms": 900
  }
}
```

Valid review outcomes are:

- `again`
- `hard`
- `good`
- `easy`

## Curl Helper Scripts

The `skill/scripts` directory contains bash helpers that use `curl` and source `skill/scripts/.env`.

Scripts available:

- `skill/scripts/create_deck.sh`
- `skill/scripts/create_card.sh`
- `skill/scripts/list_decks.sh`
- `skill/scripts/list_cards.sh`
- `skill/scripts/create_review.sh`

Update `skill/scripts/.env` before using them:

```bash
BASE_URL=http://localhost:3000
API_TOKEN=flashcards-api-token
```

Examples:

```bash
skill/scripts/create_deck.sh "French Basics" "Common vocabulary"
skill/scripts/create_card.sh 1 "Bonjour" "Hello" 1
skill/scripts/list_decks.sh
skill/scripts/list_cards.sh 1
skill/scripts/create_review.sh 1 good
```

## Database

The app uses SQLite, so the database lives in `db/*.sqlite3`.

Useful commands:

```bash
bin/rails db:create
bin/rails db:migrate
bin/rails db:reset
```

## Notes

- The app is API-only, so there are no HTML views for the flashcards domain.
- Reviews are append-only events, which keeps the schema simple and preserves study history.
- Deleting a deck cascades to its cards and reviews.
