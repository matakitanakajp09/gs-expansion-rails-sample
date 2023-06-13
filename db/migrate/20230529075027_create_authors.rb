# frozen_string_literal: true

class CreateAuthors < ActiveRecord::Migration[7.0]
  def change
    create_table :authors, id: :uuid do |t|
      t.string :name, null: false, comment: "著者名"
      t.text :bio, null: false, comment: "著者説明"
      t.timestamps
    end
  end
end
