# frozen_string_literal: true

# == Schema Information
#
# Table name: admin_account_lockings
#
#  failed_attempts(ログイン失敗回数) :integer          default(0), not null
#  locked_at(凍結時刻)               :datetime
#  unlock_token(凍結解除用トークン)  :string
#  created_at                        :datetime         not null
#  updated_at                        :datetime         not null
#  admin_id(Adminテーブルの外部キー) :uuid
#
# Indexes
#
#  index_admin_account_lockings_on_admin_id      (admin_id) UNIQUE
#  index_admin_account_lockings_on_unlock_token  (unlock_token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (admin_id => admins.id)
#
class Admin::AccountLocking < ApplicationRecord
  devise :lockable

  belongs_to :admin
end
