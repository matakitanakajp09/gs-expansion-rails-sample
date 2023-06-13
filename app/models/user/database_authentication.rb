# frozen_string_literal: true

# == Schema Information
#
# Table name: user_database_authentications
#
#  email(確認済みメールアドレス)              :string           not null
#  encrypted_password(暗号化されたパスワード) :string           not null
#  created_at                                 :datetime         not null
#  updated_at                                 :datetime         not null
#  user_id(Userテーブルの外部キー)            :uuid
#
# Indexes
#
#  index_user_database_authentications_on_email    (email) UNIQUE
#  index_user_database_authentications_on_user_id  (user_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class User::DatabaseAuthentication < ApplicationRecord
  devise :database_authenticatable, :validatable

  belongs_to :user
end
