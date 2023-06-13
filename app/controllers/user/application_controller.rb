# frozen_string_literal: true

class User::ApplicationController < ApplicationController
  layout "user"

  include Pagy::Backend

  # rescue_from Exception, with: :render500
  # rescue_from ActiveRecord::RecordNotFound,   with: :render404
  # rescue_from ActionController::RoutingError, with: :render404

  def routing_error
    raise ActionController::RoutingError, params[:path]
  end

  private

  def render404(error = nil)
    logger.info "Rendering 404 with excaption: #{error.message}" if error

    if request.format.to_sym == :json
      render json: { error: "404 Not Found" }, status: :not_found
    else
      render "user/error_404", status: :not_found
    end
  end

  def render500(error = nil)
    logger.error "Rendering 500 with excaption: #{error.message}" if error

    if request.format.to_sym == :json
      render json: { error: "500 Internal Server Error" }, status: :internal_server_error
    else
      render "user/error_500", status: :internal_server_error
    end
  end
end
