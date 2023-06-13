# frozen_string_literal: true

# == Schema Information
#
# Table name: user_registrations
#
#  id                                           :uuid             not null, primary key
#  confirmation_sent_at(確認用トークン送信時刻) :datetime
#  confirmation_token(確認用トークン)           :string           not null
#  confirmed_at(トークン確認時刻)               :datetime
#  email(確認済みメールアドレス)                :string
#  unconfirmed_email(未確認メールアドレス)      :string
#  created_at                                   :datetime         not null
#  updated_at                                   :datetime         not null
#
# Indexes
#
#  index_user_registrations_on_confirmation_token  (confirmation_token) UNIQUE
#  index_user_registrations_on_unconfirmed_email   (unconfirmed_email) UNIQUE
#
class User::Registration < ApplicationRecord
  devise :confirmable
end
