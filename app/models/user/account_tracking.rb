# frozen_string_literal: true

# == Schema Information
#
# Table name: user_account_trackings
#
#  current_sign_in_at(最終ログイン時刻) :datetime
#  current_sign_in_ip(現在のIPアドレス) :string
#  last_sign_in_at(直近のログイン時刻)  :datetime
#  last_sign_in_ip(直近のIPアドレス)    :string
#  sign_in_count(ログイン回数)          :integer          default(0), not null
#  created_at                           :datetime         not null
#  updated_at                           :datetime         not null
#  user_id(Userテーブルの外部キー)      :uuid
#
# Indexes
#
#  index_user_account_trackings_on_user_id  (user_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class User::AccountTracking < ApplicationRecord
  devise :trackable

  belongs_to :user
end
