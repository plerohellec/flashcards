class CardReview < ApplicationRecord
  OUTCOMES = %w[again hard good easy].freeze

  belongs_to :card

  validates :outcome, presence: true, inclusion: { in: OUTCOMES }
  validates :reviewed_at, presence: true
  validates :response_time_ms, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
end
