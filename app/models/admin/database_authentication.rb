# frozen_string_literal: true

# == Schema Information
#
# Table name: admin_database_authentications
#
#  email(確認済みメールアドレス)              :string           not null
#  encrypted_password(暗号化されたパスワード) :string           not null
#  created_at                                 :datetime         not null
#  updated_at                                 :datetime         not null
#  admin_id(Userテーブルの外部キー)           :uuid
#
# Indexes
#
#  index_admin_database_authentications_on_admin_id  (admin_id) UNIQUE
#  index_admin_database_authentications_on_email     (email) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (admin_id => admins.id)
#
class Admin::DatabaseAuthentication < ApplicationRecord
  devise :database_authenticatable, :validatable
  self.primary_key = :admin_id

  belongs_to :admin
end
