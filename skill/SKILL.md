---
name: flashcards-api-scripts
description: "Use when creating or using bash and curl helper scripts for the flashcards API, including deck, card, review, and list helpers from skill/scripts/.env."
---

# Flashcards API Scripts

Plain bash helpers for exercising the flashcards API with `curl`.

## Files

- `skill/scripts/.env` - local API settings, including the bearer token
- `skill/scripts/create_deck.sh` - create a deck
- `skill/scripts/create_card.sh` - create a card within a deck
- `skill/scripts/list_decks.sh` - list decks
- `skill/scripts/list_cards.sh` - list cards in a deck
- `skill/scripts/create_review.sh` - create a card review

## Usage

1. Edit `skill/scripts/.env` with your local API token and base URL.
2. Run the scripts from anywhere in the repository.
3. The scripts print the raw API response so you can inspect created ids and payloads.
