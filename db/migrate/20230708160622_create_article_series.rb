# frozen_string_literal: true

class CreateArticleSeries < ActiveRecord::Migration[7.0]
  def change
    create_table :article_series do |t|
      t.references :article, foreign_key: true, deferrable: :deferred, type: :uuid, comment: "Articleテーブルの外部キー"
      t.references :series, foreign_key: true, deferrable: :deferred, type: :uuid, comment: "Seriesテーブルの外部キー"
      t.integer :position, default: 100, comment: "順番"
      t.timestamps
    end
  end
end
