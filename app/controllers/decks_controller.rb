class DecksController < ApplicationController
  before_action :set_deck, only: %i[show update destroy]

  def index
    render json: Deck.order(:id)
  end

  def show
    render json: @deck
  end

  def create
    deck = Deck.new(deck_params)

    if deck.save
      render json: deck, status: :created
    else
      render_validation_errors(deck)
    end
  end

  def update
    if @deck.update(deck_params)
      render json: @deck
    else
      render_validation_errors(@deck)
    end
  end

  def destroy
    @deck.destroy
    head :no_content
  end

  private

  def set_deck
    @deck = Deck.find(params[:id])
  end

  def deck_params
    params.expect(deck: %i[name description])
  end
end
