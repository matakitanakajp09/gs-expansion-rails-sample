# frozen_string_literal: true

class CreateAdminPasswordResetRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :admin_password_reset_requests, id: false, primary_key: "admin_id" do |t|
      t.references :admin, foreign_key: true, deferrable: :deferred, type: :uuid, index: { unique: true },
                           comment: "Adminテーブルの外部キー"
      t.string :reset_password_token, comment: "パスワードリセット用トークン"
      t.datetime :reset_password_sent_at, comment: "パスワードリセット送信時刻"
      t.timestamps
    end

    add_index :admin_password_reset_requests, :reset_password_token, unique: true
  end
end
