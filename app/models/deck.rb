class Deck < ApplicationRecord
  has_many :cards, dependent: :destroy
  has_many :card_reviews, through: :cards

  validates :name, presence: true
end
