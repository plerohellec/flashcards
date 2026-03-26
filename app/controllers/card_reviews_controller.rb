class CardReviewsController < ApplicationController
  before_action :set_card, only: %i[index create]
  before_action :set_card_review, only: :show

  def index
    render json: @card.card_reviews.order(reviewed_at: :desc, id: :desc)
  end

  def show
    render json: @card_review
  end

  def create
    card_review = @card.card_reviews.new(card_review_params)

    if card_review.save
      render json: card_review, status: :created
    else
      render_validation_errors(card_review)
    end
  end

  private

  def set_card
    @card = Card.find(params[:card_id])
  end

  def set_card_review
    @card_review = CardReview.find(params[:id])
  end

  def card_review_params
    params.expect(card_review: %i[outcome reviewed_at response_time_ms])
  end
end
