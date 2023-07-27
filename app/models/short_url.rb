# frozen_string_literal: true

class ShortUrl < ApplicationRecord
  belongs_to :admin

  validates :label_name, length: { maximum: 255, too_long: "最大%<count>s文字まで使えます" }, presence: true
  validates :original_url, presence: true
  validates :utm_source, presence: true, length: { maximum: 255, too_long: "最大%<count>s文字まで使えます" }, presence: true
  validates :utm_medium, presence: true, length: { maximum: 255, too_long: "最大%<count>s文字まで使えます" }, presence: true
  validates :utm_campaign, presence: true, length: { maximum: 255, too_long: "最大%<count>s文字まで使えます" }, presence: true

  before_create :fill_custom_key

  def fill_custom_key
    self.custom_key = loop do
      uuid = SecureRandom.alphanumeric(10) # JWlXD6cCxM
      break uuid unless self.class.exists?(custom_key: uuid)
    end
  end

  def short_url
    Rails.application.routes.url_helpers.short_url_url(
      id: custom_key,
      host: Rails.application.routes.default_url_options[:host],
      protocol: Rails.application.routes.default_url_options[:protocol]
    )
  end

  def parameter_url
    query = {
      utm_source: self&.utm_source,
      utm_medium: self&.utm_medium,
      utm_campaign: self&.utm_campaign
    }
    uri = URI.parse(self&.original_url)
    uri.query = query.to_param
    uri.to_s
  end
end
