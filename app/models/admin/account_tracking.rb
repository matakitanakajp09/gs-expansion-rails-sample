# frozen_string_literal: true

# == Schema Information
#
# Table name: admin_account_trackings
#
#  current_sign_in_at(最終ログイン時刻) :datetime
#  current_sign_in_ip(現在のIPアドレス) :string
#  last_sign_in_at(直近のログイン時刻)  :datetime
#  last_sign_in_ip(直近のIPアドレス)    :string
#  sign_in_count(ログイン回数)          :integer          default(0), not null
#  created_at                           :datetime         not null
#  updated_at                           :datetime         not null
#  admin_id(Adminテーブルの外部キー)    :uuid
#
# Indexes
#
#  index_admin_account_trackings_on_admin_id  (admin_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (admin_id => admins.id)
#
class Admin::AccountTracking < ApplicationRecord
  devise :trackable

  belongs_to :admin
end
