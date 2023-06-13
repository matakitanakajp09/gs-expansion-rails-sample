# frozen_string_literal: true

class CreateAdminAccountLockings < ActiveRecord::Migration[7.0]
  def change
    create_table :admin_account_lockings, id: false, primary_key: "admin_id" do |t|
      t.references :admin, foreign_key: true, deferrable: :deferred, type: :uuid, index: { unique: true },
                           comment: "Adminテーブルの外部キー"
      t.integer :failed_attempts, default: 0, null: false, comment: "ログイン失敗回数"
      t.string :unlock_token, comment: "凍結解除用トークン"
      t.datetime :locked_at, comment: "凍結時刻"
      t.timestamps
    end

    add_index :admin_account_lockings, :unlock_token, unique: true
  end
end
