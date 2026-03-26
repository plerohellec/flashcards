require "test_helper"

class DecksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @deck = decks(:french)
  end

  test "rejects requests without an api token" do
    get decks_url

    assert_response :unauthorized
  end

  test "lists decks" do
    get decks_url, headers: auth_headers

    assert_response :success
    assert_equal 2, json_response.size
  end

  test "creates a deck" do
    assert_difference("Deck.count", 1) do
      post decks_url,
        params: { deck: { name: "Science", description: "Core facts" } }.to_json,
        headers: auth_headers
    end

    assert_response :created
    assert_equal "Science", json_response["name"]
  end

  test "updates a deck" do
    patch deck_url(@deck),
      params: { deck: { description: "Updated description" } }.to_json,
      headers: auth_headers

    assert_response :success
    assert_equal "Updated description", @deck.reload.description
  end

  test "destroys a deck and its dependent records" do
    card = cards(:bonjour)

    assert_difference("Deck.count", -1) do
      assert_difference("Card.count", -1) do
        assert_difference("CardReview.count", -1) do
          delete deck_url(@deck), headers: auth_headers
        end
      end
    end

    assert_response :no_content
    assert_raises(ActiveRecord::RecordNotFound) { card.reload }
  end
end
