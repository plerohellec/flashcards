class CreateCardReviews < ActiveRecord::Migration[8.1]
  def change
    create_table :card_reviews do |t|
      t.references :card, null: false, foreign_key: { on_delete: :cascade }
      t.string :outcome, null: false
      t.datetime :reviewed_at, null: false
      t.integer :response_time_ms

      t.timestamps
    end

    add_index :card_reviews, [ :card_id, :reviewed_at ]
  end
end
