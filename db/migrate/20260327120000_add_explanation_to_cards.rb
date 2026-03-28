class AddExplanationToCards < ActiveRecord::Migration[8.1]
  def change
    add_column :cards, :explanation, :text
  end
end
