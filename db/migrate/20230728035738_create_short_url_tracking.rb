# frozen_string_literal: true

class CreateShortUrlTracking < ActiveRecord::Migration[7.0]
  def change
    create_table :short_url_trackings, id: :uuid do |t|
      t.references :short_url, foreign_key: true, deferrable: :deferred, type: :uuid, comment: "ShortUrlテーブルの外部キー"
      t.enum :tracking_type, enum_type: :tracking_type, default: :imp, comment: "追跡タイプ"
      t.datetime :created_at, null: false
    end
  end
end
