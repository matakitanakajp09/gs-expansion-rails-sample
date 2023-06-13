# frozen_string_literal: true

# This migration comes from action_text (originally 20180528164100)
class CreateActionTextTables < ActiveRecord::Migration[7.0]
  def change
    # Use Active Record's configured type for primary and foreign keys
    primary_key_type, foreign_key_type = primary_and_foreign_key_types

    create_table :action_text_rich_texts, id: primary_key_type do |t|
      t.string     :name, null: false
      t.text       :body, size: :long
      t.references :record, null: false, polymorphic: true, index: false, type: foreign_key_type

      t.timestamps

      t.index %i[record_type record_id name], name: "index_action_text_rich_texts_uniqueness", unique: true
    end
  end

  private

  def primary_and_foreign_key_types
    primary_key_type = :uuid
    foreign_key_type = :uuid
    [primary_key_type, foreign_key_type]
  end
end
