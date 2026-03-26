class CardsController < ApplicationController
  before_action :set_deck, only: %i[index create]
  before_action :set_card, only: %i[show update destroy]

  def index
    render json: @deck.cards.order(:position, :id)
  end

  def show
    render json: @card
  end

  def create
    card = @deck.cards.new(card_params)

    if card.save
      render json: card, status: :created
    else
      render_validation_errors(card)
    end
  end

  def update
    if @card.update(card_params)
      render json: @card
    else
      render_validation_errors(@card)
    end
  end

  def destroy
    @card.destroy
    head :no_content
  end

  private

  def set_deck
    @deck = Deck.find(params[:deck_id])
  end

  def set_card
    @card = Card.find(params[:id])
  end

  def card_params
    params.expect(card: %i[front back position])
  end
end
