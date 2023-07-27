# frozen_string_literal: true

class CreateShortUrl < ActiveRecord::Migration[7.0]
  def change
    create_table :short_urls, id: :uuid do |t|
      t.references :admin, foreign_key: true, deferrable: :deferred, type: :uuid, comment: "Adminテーブルの外部キー"
      t.string :custom_key, null: false, comment: "カスタムキー"
      t.string :label_name, null: false, comment: "URLラベルネーム"
      t.text :original_url, null: false, comment: "短縮元URL"
      t.string :utm_source, null: false, comment: "GA用参照元"
      t.string :utm_medium, null: false, comment: "GA用メディア"
      t.string :utm_campaign, null: false, comment: "GA用キャンペーン名"
      t.timestamps
    end
  end
end
