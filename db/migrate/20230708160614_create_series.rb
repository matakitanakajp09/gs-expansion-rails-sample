# frozen_string_literal: true

class CreateSeries < ActiveRecord::Migration[7.0]
  def change
    create_table :series, id: :uuid do |t|
      t.string :title, null: false, comment: "シリーズ名"
      t.string :subtitle, comment: "シリーズのサブタイトル"
      t.enum :current_status, enum_type: :current_status, default: :draft, comment: "ステータス"
      t.datetime :published_at, comment: "公開日"
      t.integer :position, default: 100, comment: "順番"
      t.timestamps
    end
  end
end
