# frozen_string_literal: true

class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles, id: :uuid do |t|
      t.references :author, foreign_key: true, deferrable: :deferred, type: :uuid, comment: "Authorテーブルの外部キー"
      t.references :category, foreign_key: true, deferrable: :deferred, type: :uuid, comment: "Categoryテーブルの外部キー"
      t.string :title, comment: "記事タイトル"
      t.string :subtitle, comment: "記事サブタイトル"
      t.enum :current_status, enum_type: :current_status, default: :draft, comment: "記事ステータス"
      t.datetime :scheduled_published_at, comment: "公開予約日"
      t.datetime :published_at, comment: "公開日"
      t.boolean :is_sponsored, default: false, comment: "スポンサー記事か否か"
      t.string :sponsor_name, comment: "スポンサー名"
      t.timestamps
    end
  end
end
