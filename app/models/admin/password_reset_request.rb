# frozen_string_literal: true

# == Schema Information
#
# Table name: admin_password_reset_requests
#
#  reset_password_sent_at(パスワードリセット送信時刻) :datetime
#  reset_password_token(パスワードリセット用トークン) :string
#  created_at                                         :datetime         not null
#  updated_at                                         :datetime         not null
#  admin_id(Adminテーブルの外部キー)                  :uuid
#
# Indexes
#
#  index_admin_password_reset_requests_on_admin_id              (admin_id) UNIQUE
#  index_admin_password_reset_requests_on_reset_password_token  (reset_password_token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (admin_id => admins.id)
#
class Admin::PasswordResetRequest < ApplicationRecord
  devise :recoverable

  belongs_to :admin
end
