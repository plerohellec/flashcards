# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_03_25_235320) do
  create_table "card_reviews", force: :cascade do |t|
    t.integer "card_id", null: false
    t.datetime "created_at", null: false
    t.string "outcome"
    t.integer "response_time_ms"
    t.datetime "reviewed_at"
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_card_reviews_on_card_id"
  end

  create_table "cards", force: :cascade do |t|
    t.text "back"
    t.datetime "created_at", null: false
    t.integer "deck_id", null: false
    t.text "front"
    t.integer "position"
    t.datetime "updated_at", null: false
    t.index ["deck_id"], name: "index_cards_on_deck_id"
  end

  create_table "decks", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "card_reviews", "cards"
  add_foreign_key "cards", "decks"
end
