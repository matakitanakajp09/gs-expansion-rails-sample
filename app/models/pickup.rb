# frozen_string_literal: true

class Pickup < ApplicationRecord
  acts_as_list
  include Displayable

  has_one_attached :thumbnail

  validates :name, presence: true, length: { maximum: 255 }
end