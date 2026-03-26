class Card < ApplicationRecord
  belongs_to :deck
  has_many :card_reviews, dependent: :destroy

  validates :front, presence: true
  validates :back, presence: true
  validates :position, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
end
