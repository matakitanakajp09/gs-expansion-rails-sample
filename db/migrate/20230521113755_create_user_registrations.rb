# frozen_string_literal: true

class CreateUserRegistrations < ActiveRecord::Migration[7.0]
  def change
    create_table :user_registrations, id: :uuid do |t|
      t.string :confirmation_token, null: false, comment: "確認用トークン"
      t.datetime :confirmed_at, comment: "トークン確認時刻"
      t.datetime :confirmation_sent_at, comment: "確認用トークン送信時刻"
      t.string :unconfirmed_email, comment: "未確認メールアドレス"
      t.string :email, comment: "確認済みメールアドレス"
      t.timestamps
    end

    add_index :user_registrations, :confirmation_token, unique: true
    add_index :user_registrations, :unconfirmed_email, unique: true
  end
end
