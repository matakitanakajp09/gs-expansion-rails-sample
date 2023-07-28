# frozen_string_literal: true

class ShortUrl < ApplicationRecord
  belongs_to :admin
  has_many :short_url_trackings

  validates :label_name, length: { maximum: 255, too_long: "最大%<count>s文字まで使えます" }, presence: true
  validates :original_url, presence: true
  validates :utm_source, presence: true, length: { maximum: 255, too_long: "最大%<count>s文字まで使えます" }, presence: true
  validates :utm_medium, presence: true, length: { maximum: 255, too_long: "最大%<count>s文字まで使えます" }, presence: true
  validates :utm_campaign, presence: true, length: { maximum: 255, too_long: "最大%<count>s文字まで使えます" }, presence: true

  before_create :fill_custom_key

  IMP = "imp"
  CLICK = "click"

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

  def imp!
    tracking_to_redis!(tracking_type: IMP)
  end

  def click!
    tracking_to_redis!(tracking_type: CLICK)
  end

  def tracking_cache_key
    "#{::CmsRedis::ShortUrl::CACHE_KEY}:#{id}"
  end

  def connect_redis
    ::CmsRedis::ShortUrl.new(tracking_cache_key)
  end

  def tracking_to_redis!(tracking_type: IMP)
    hash = {
      short_url_id: id,
      tracking_type: tracking_type,
      created_at: Time.current.to_i
    }
    connect_redis.set(hash)
  end

  def fetch_from_redis
    connect_redis.fetch
  end

  def self.fetch_all_from_redis
    all.map do |short_url|
      short_url&.fetch_from_redis
    end.flatten
  end

  def del_redis
    connect_redis.del
  end

  def self.del_all_redis
    all.map do |del_redis|
      del_redis&.del_redis
    end
  end
end
