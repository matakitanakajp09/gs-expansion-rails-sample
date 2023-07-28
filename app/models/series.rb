# frozen_string_literal: true

# == Schema Information
#
# Table name: topics
#
#  id                               :uuid             not null, primary key
#  current_status(ステータス)       :enum             default("draft")
#  position(順番)                   :integer          default(100)
#  published_at(公開日)             :datetime
#  slug(スラッグ)                   :string           not null
#  subtitle(トピックのサブタイトル) :string
#  title(トピック名)                :string           not null
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#
# Indexes
#
#  index_topics_on_slug  (slug) UNIQUE
#
class Series < ApplicationRecord
  acts_as_list

  has_many :article_series, -> { order(position: :asc) }
  has_many :articles, through: :article_series

  has_one_attached :thumbnail

  validates :title, presence: true, length: { maximum: 255 }
  validates :subtitle, presence: true, length: { maximum: 255 }

  enum current_status: CmsStatus::TYPES

  scope :published, -> { where(current_status: "published") }

  def self.update_position!(series = [])
    change_columns = %i[position]
    return false if series.blank?

    targets = series.map.with_index do |tmp, idx|
      order = idx + 1
      tmp.position = order
      tmp
    end
    Series.import targets, on_duplicate_key_update: change_columns, validate: false
    true
  end
end
