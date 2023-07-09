# frozen_string_literal: true

# == Schema Information
#
# Table name: articles
#
#  id                                  :uuid             not null, primary key
#  category_type(Category Type)        :enum             default("horoscope")
#  current_status(Current Status)      :enum             default("draft")
#  published_at(公開日)                :datetime
#  scheduled_published_at(公開予約日)  :datetime
#  slug(Slug)                          :string           not null
#  subtitle(Sub title)                 :string
#  thumbnail(サムネイル)               :string
#  title(Title)                        :string           not null
#  created_at                          :datetime         not null
#  updated_at                          :datetime         not null
#  author_id(Authorテーブルの外部キー) :uuid
#
# Indexes
#
#  index_articles_on_author_id  (author_id)
#  index_articles_on_slug       (slug) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (author_id => authors.id)
#
class Article < ApplicationRecord
  has_rich_text :content

  belongs_to :author
  belongs_to :category
  has_many :article_tags
  has_many :tags, through: :article_tags
  has_one :article_series
  has_one :series, through: :article_series

  accepts_nested_attributes_for :article_tags, allow_destroy: true
  accepts_nested_attributes_for :article_series, allow_destroy: true

  has_one_attached :thumbnail do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 120]
  end

  enum current_status: CmsStatus::TYPES

  scope :published, -> { where(current_status: "published") }
  scope :by_category, ->(category_name) { joins(:category).where("category.name": category_name) }

  validates :title, length: { maximum: 255, too_long: "最大%<count>s文字まで使えます" }, presence: true
  validates :subtitle, length: { maximum: 255, too_long: "最大%<count>s文字まで使えます" }, presence: true

  def reject_article_series(attributes)
    attributes.except(:series_id).values.all?(&:blank?)
  end
end
