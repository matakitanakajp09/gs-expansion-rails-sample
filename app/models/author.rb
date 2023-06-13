# frozen_string_literal: true

# == Schema Information
#
# Table name: authors
#
#  id             :uuid             not null, primary key
#  bio(著者説明)  :text             not null
#  name(著者名)   :string           not null
#  slug(スラッグ) :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_authors_on_slug  (slug) UNIQUE
#
class Author < ApplicationRecord
  has_many :articles
  has_one_attached :icon

  validates :name, length: { maximum: 255, too_long: "最大%<count>s文字まで使えます" }, presence: true
end
