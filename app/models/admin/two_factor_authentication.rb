# frozen_string_literal: true

# MEMO: 2段階認証を追加する場合はこちらのモデルを作成して使用する
# class Admin::TwoFactorAuthentication < ApplicationRecord
#   devise :two_factor_authenticatable, otp_secret_encryption_key: Settings.two_factor.devise.encryption_key
#   devise :two_factor_backupable, otp_backup_code_length: 32, otp_number_of_backup_codes: 10
#   serialize :otp_backup_codes, JSON
#   serialize :otp_plain_backup_codes, JSON

#   belongs_to :admin
# end
