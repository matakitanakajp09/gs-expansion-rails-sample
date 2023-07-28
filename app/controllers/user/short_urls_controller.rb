# frozen_string_literal: true

class User::ShortUrlsController < User::ApplicationController
  def show
    redirect_to root_url and return unless params[:id].present? && params[:id] =~ Regexp.new("\\A[a-zA-Z0-9]{10}+\\z")

    @short_url = ShortUrl.find_by(custom_key: params[:id])
    redirect_to root_url and return unless @short_url.present?

    # imp計測
    @short_url&.imp!
  end

  def click
    redirect_to root_url and return unless params[:id].present? && params[:id] =~ Regexp.new("\\A[a-zA-Z0-9]{10}+\\z")

    @short_url = ShortUrl.find_by(custom_key: params[:id])
    redirect_to root_url and return unless @short_url.present?

    # click計測
    @short_url&.click!

    redirect_to @short_url&.parameter_url, allow_other_host: true
  end
end
