# frozen_string_literal: true

class User::ShortUrlsController < User::ApplicationController
  def show
    redirect_to root_url and return unless params[:id].present? && params[:id] =~ Regexp.new("\\A[a-zA-Z0-9]{10}+\\z")

    @short_url = ShortUrl.find_by(custom_key: params[:id])
    redirect_to root_url and return unless @short_url.present?
  end
end
