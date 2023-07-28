# frozen_string_literal: true

class CreateArticleTags < ActiveRecord::Migration[7.0]
  def change
    create_table :article_tags do |t|
      t.references :article, foreign_key: true, deferrable: :deferred, type: :uuid, comment: "Articleテーブルの外部キー"
      t.references :tag, foreign_key: true, deferrable: :deferred, type: :uuid, comment: "Tagテーブルの外部キー"
      t.timestamps
    end
  end
end
