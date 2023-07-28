# frozen_string_literal: true

class ShortUrlTracking < ApplicationRecord
  belongs_to :short_url

  enum tracking_type: {
    imp: "imp",
    click: "click"
  }

  scope :when_created_at, ->(date) { where(created_at: date.beginning_of_day..date.end_of_day) }
  scope :find_by_short_url_id, ->(short_url_id) { where(short_url_id: short_url_id) }

  def self.import_all!
    targets = ShortUrl.fetch_all_from_redis.map { |hash| hash_to_attribute(hash) }
    result = import targets
    ShortUrl.del_all_redis if result.ids.present?
  end

  def self.hash_to_attribute(hash)
    new(
      short_url_id: hash[:short_url_id],
      tracking_type: hash[:tracking_type],
      created_at: DateTime.strptime(hash[:created_at].to_s, "%s")
    )
  end

  def self.created_today
    when_created_at(Date.today)
  end
end
