class ApplicationController < ActionController::API
  before_action :authenticate_request!

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActionController::ParameterMissing, with: :render_bad_request

  private

  def authenticate_request!
    provided_token = bearer_token
    expected_token = Rails.application.config.x.api_token.to_s

    if provided_token.blank? || expected_token.blank? || !ActiveSupport::SecurityUtils.secure_compare(provided_token, expected_token)
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end

  def bearer_token
    authorization = request.authorization.to_s
    scheme, token = authorization.split(" ", 2)
    return unless scheme&.casecmp?("Bearer")

    token
  end

  def render_validation_errors(record)
    render json: { errors: record.errors.full_messages }, status: :unprocessable_entity
  end

  def render_not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def render_bad_request(exception)
    render json: { error: exception.message }, status: :bad_request
  end
end
