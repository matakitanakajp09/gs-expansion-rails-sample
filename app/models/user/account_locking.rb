# frozen_string_literal: true

# == Schema Information
#
# Table name: user_account_lockings
#
#  failed_attempts(ログイン失敗回数) :integer          default(0), not null
#  locked_at(凍結時刻)               :datetime
#  unlock_token(凍結解除用トークン)  :string
#  created_at                        :datetime         not null
#  updated_at                        :datetime         not null
#  user_id(Userテーブルの外部キー)   :uuid
#
# Indexes
#
#  index_user_account_lockings_on_unlock_token  (unlock_token) UNIQUE
#  index_user_account_lockings_on_user_id       (user_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class User::AccountLocking < ApplicationRecord
  devise :lockable

  belongs_to :user
end
