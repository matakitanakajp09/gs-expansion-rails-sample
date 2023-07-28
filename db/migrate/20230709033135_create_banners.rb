# frozen_string_literal: true

class CreateBanners < ActiveRecord::Migration[7.0]
  def change
    create_table :banners, id: :uuid do |t|
      t.string :name, null: false, comment: "バナー名"
      t.datetime :started_at, comment: "掲載開始日"
      t.datetime :expired_at, comment: "掲載終了日"
      t.integer :position, default: 100, comment: "順番"
      t.string :url, comment: "url"
      t.timestamps
    end
  end
end
