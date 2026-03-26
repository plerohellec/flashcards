class CreateDecks < ActiveRecord::Migration[8.1]
  def change
    create_table :decks do |t|
      t.string :name, null: false
      t.text :description

      t.timestamps
    end

    add_index :decks, :name
  end
end
