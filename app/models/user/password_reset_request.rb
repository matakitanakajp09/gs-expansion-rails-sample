# frozen_string_literal: true

# == Schema Information
#
# Table name: user_password_reset_requests
#
#  reset_password_sent_at(パスワードリセット送信時刻) :datetime
#  reset_password_token(パスワードリセット用トークン) :string
#  created_at                                         :datetime         not null
#  updated_at                                         :datetime         not null
#  user_id(Userテーブルの外部キー)                    :uuid
#
# Indexes
#
#  index_user_password_reset_requests_on_reset_password_token  (reset_password_token) UNIQUE
#  index_user_password_reset_requests_on_user_id               (user_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class User::PasswordResetRequest < ApplicationRecord
  devise :recoverable

  belongs_to :user
end
