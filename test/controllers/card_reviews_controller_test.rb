require "test_helper"

class CardReviewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @card = cards(:bonjour)
    @review = card_reviews(:bonjour_good)
  end

  test "lists reviews for a card" do
    get card_reviews_url(@card), headers: auth_headers

    assert_response :success
    assert_equal [ @review.id ], json_response.map { |review| review["id"] }
  end

  test "shows a review" do
    get card_review_url(@review), headers: auth_headers

    assert_response :success
    assert_equal @review.id, json_response["id"]
  end

  test "creates an append-only review event" do
    reviewed_at = Time.current.utc.iso8601

    assert_difference("CardReview.count", 1) do
      post card_reviews_url(@card),
        params: { card_review: { outcome: "easy", reviewed_at: reviewed_at, response_time_ms: 700 } }.to_json,
        headers: auth_headers
    end

    assert_response :created
    assert_equal "easy", json_response["outcome"]
  end

  test "rejects unsupported review outcomes" do
    post card_reviews_url(@card),
      params: { card_review: { outcome: "invalid", reviewed_at: Time.current.utc.iso8601 } }.to_json,
      headers: auth_headers

    assert_response :unprocessable_entity
  end
end
