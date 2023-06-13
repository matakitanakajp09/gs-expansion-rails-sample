# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :articles

  validates :name, format: { with: /\A[a-zA-Z]+\z/.freeze, message: "は半角英字のみです" },
                   length: { maximum: 255, too_long: "最大%<count>s文字まで使えます" }, presence: true

  STR_BUSINESS = "business"
  STR_CAREER = "career"
  STR_TECHNOLOGY = "technology"
  STR_FINANCE = "finance"
end
