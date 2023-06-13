# frozen_string_literal: true

# == Schema Information
#
# Table name: admins
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Admin < ApplicationRecord
  devise :authenticatable

  has_one :admin_database_authentication, primary_key: :admin_id
  has_one :admin_account_locking, primary_key: :admin_id
  has_one :admin_account_tracking, primary_key: :admin_id
  has_one :admin_password_reset_request, primary_key: :admin_id
end
