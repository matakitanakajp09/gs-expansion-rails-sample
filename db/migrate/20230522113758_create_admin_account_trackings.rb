# frozen_string_literal: true

class CreateAdminAccountTrackings < ActiveRecord::Migration[7.0]
  def change
    create_table :admin_account_trackings, id: false, primary_key: "admin_id" do |t|
      t.references :admin, foreign_key: true, deferrable: :deferred, type: :uuid, index: { unique: true },
                           comment: "Adminテーブルの外部キー"
      t.integer :sign_in_count, default: 0, null: false, comment: "ログイン回数"
      t.datetime :current_sign_in_at, comment: "最終ログイン時刻"
      t.datetime :last_sign_in_at, comment: "直近のログイン時刻"
      t.string :current_sign_in_ip, comment: "現在のIPアドレス"
      t.string :last_sign_in_ip, comment: "直近のIPアドレス"
      t.timestamps
    end
  end
end
