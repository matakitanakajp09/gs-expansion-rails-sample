# frozen_string_literal: true

class CreateAdminDatabaseAuthentications < ActiveRecord::Migration[7.0]
  def change
    create_table :admin_database_authentications, id: false, primary_key: "admin_id" do |t|
      t.references :admin, foreign_key: true, deferrable: :deferred, type: :uuid, index: { unique: true },
                           comment: "Userテーブルの外部キー"
      t.string :email, null: false, comment: "確認済みメールアドレス"
      t.string :encrypted_password, null: false, comment: "暗号化されたパスワード"
      t.timestamps
    end

    add_index :admin_database_authentications, :email, unique: true
  end
end
