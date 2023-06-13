# frozen_string_literal: true

class CreateAdmins < ActiveRecord::Migration[7.0]
  def change
    create_table :admins, id: :uuid do |t|
      t.string :full_name, null: false, comment: "管理者名"
      t.timestamps
    end
  end
end
