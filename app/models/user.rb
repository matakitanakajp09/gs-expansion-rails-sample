# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  devise :authenticatable

  has_one :user_database_authentication, primary_key: :user_id
  has_one :user_account_locking, primary_key: :user_id
  has_one :user_account_tracking, primary_key: :user_id
  has_one :user_password_reset_request, primary_key: :user_id
end
