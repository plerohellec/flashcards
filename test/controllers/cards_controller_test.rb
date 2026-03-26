require "test_helper"

class CardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @deck = decks(:french)
    @card = cards(:bonjour)
  end

  test "lists cards for a deck" do
    get deck_cards_url(@deck), headers: auth_headers

    assert_response :success
    assert_equal [ @card.id ], json_response.map { |card| card["id"] }
  end

  test "creates a card for a deck" do
    assert_difference("Card.count", 1) do
      post deck_cards_url(@deck),
        params: { card: { front: "Merci", back: "Thank you", position: 2 } }.to_json,
        headers: auth_headers
    end

    assert_response :created
    assert_equal @deck.id, json_response["deck_id"]
  end

  test "updates a card" do
    patch card_url(@card),
      params: { card: { back: "Hi" } }.to_json,
      headers: auth_headers

    assert_response :success
    assert_equal "Hi", @card.reload.back
  end

  test "rejects invalid cards" do
    post deck_cards_url(@deck),
      params: { card: { front: "", back: "Missing front" } }.to_json,
      headers: auth_headers

    assert_response :unprocessable_entity
  end

  test "destroys a card and its reviews" do
    assert_difference("Card.count", -1) do
      assert_difference("CardReview.count", -1) do
        delete card_url(@card), headers: auth_headers
      end
    end

    assert_response :no_content
  end
end
