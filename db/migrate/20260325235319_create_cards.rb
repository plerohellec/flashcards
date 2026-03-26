class CreateCards < ActiveRecord::Migration[8.1]
  def change
    create_table :cards do |t|
      t.references :deck, null: false, foreign_key: { on_delete: :cascade }
      t.text :front, null: false
      t.text :back, null: false
      t.integer :position

      t.timestamps
    end

    add_index :cards, [ :deck_id, :position ]
  end
end
