# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_05_29_113755) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "current_status", ["draft", "published", "archived", "trashed"]

  create_table "action_text_rich_texts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.uuid "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.uuid "record_id", null: false
    t.uuid "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admin_account_lockings", id: false, force: :cascade do |t|
    t.uuid "admin_id", comment: "Adminテーブルの外部キー"
    t.integer "failed_attempts", default: 0, null: false, comment: "ログイン失敗回数"
    t.string "unlock_token", comment: "凍結解除用トークン"
    t.datetime "locked_at", comment: "凍結時刻"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_admin_account_lockings_on_admin_id", unique: true
    t.index ["unlock_token"], name: "index_admin_account_lockings_on_unlock_token", unique: true
  end

  create_table "admin_account_trackings", id: false, force: :cascade do |t|
    t.uuid "admin_id", comment: "Adminテーブルの外部キー"
    t.integer "sign_in_count", default: 0, null: false, comment: "ログイン回数"
    t.datetime "current_sign_in_at", comment: "最終ログイン時刻"
    t.datetime "last_sign_in_at", comment: "直近のログイン時刻"
    t.string "current_sign_in_ip", comment: "現在のIPアドレス"
    t.string "last_sign_in_ip", comment: "直近のIPアドレス"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_admin_account_trackings_on_admin_id", unique: true
  end

  create_table "admin_database_authentications", id: false, force: :cascade do |t|
    t.uuid "admin_id", comment: "Userテーブルの外部キー"
    t.string "email", null: false, comment: "確認済みメールアドレス"
    t.string "encrypted_password", null: false, comment: "暗号化されたパスワード"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_admin_database_authentications_on_admin_id", unique: true
    t.index ["email"], name: "index_admin_database_authentications_on_email", unique: true
  end

  create_table "admin_password_reset_requests", id: false, force: :cascade do |t|
    t.uuid "admin_id", comment: "Adminテーブルの外部キー"
    t.string "reset_password_token", comment: "パスワードリセット用トークン"
    t.datetime "reset_password_sent_at", comment: "パスワードリセット送信時刻"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_admin_password_reset_requests_on_admin_id", unique: true
    t.index ["reset_password_token"], name: "index_admin_password_reset_requests_on_reset_password_token", unique: true
  end

  create_table "admin_registrations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "confirmation_token", null: false, comment: "確認用トークン"
    t.datetime "confirmed_at", comment: "トークン確認時刻"
    t.datetime "confirmation_sent_at", comment: "確認用トークン送信時刻"
    t.string "unconfirmed_email", comment: "未確認メールアドレス"
    t.string "email", comment: "確認済みメールアドレス"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_admin_registrations_on_confirmation_token", unique: true
    t.index ["unconfirmed_email"], name: "index_admin_registrations_on_unconfirmed_email", unique: true
  end

  create_table "admins", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "full_name", null: false, comment: "管理者名"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "authors", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false, comment: "著者名"
    t.text "bio", null: false, comment: "著者説明"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false, comment: "カテゴリ名"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_account_lockings", id: false, force: :cascade do |t|
    t.uuid "user_id", comment: "Userテーブルの外部キー"
    t.integer "failed_attempts", default: 0, null: false, comment: "ログイン失敗回数"
    t.string "unlock_token", comment: "凍結解除用トークン"
    t.datetime "locked_at", comment: "凍結時刻"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["unlock_token"], name: "index_user_account_lockings_on_unlock_token", unique: true
    t.index ["user_id"], name: "index_user_account_lockings_on_user_id", unique: true
  end

  create_table "user_account_trackings", id: false, force: :cascade do |t|
    t.uuid "user_id", comment: "Userテーブルの外部キー"
    t.integer "sign_in_count", default: 0, null: false, comment: "ログイン回数"
    t.datetime "current_sign_in_at", comment: "最終ログイン時刻"
    t.datetime "last_sign_in_at", comment: "直近のログイン時刻"
    t.string "current_sign_in_ip", comment: "現在のIPアドレス"
    t.string "last_sign_in_ip", comment: "直近のIPアドレス"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_account_trackings_on_user_id", unique: true
  end

  create_table "user_database_authentications", id: false, force: :cascade do |t|
    t.uuid "user_id", comment: "Userテーブルの外部キー"
    t.string "email", null: false, comment: "確認済みメールアドレス"
    t.string "encrypted_password", null: false, comment: "暗号化されたパスワード"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_user_database_authentications_on_email", unique: true
    t.index ["user_id"], name: "index_user_database_authentications_on_user_id", unique: true
  end

  create_table "user_password_reset_requests", id: false, force: :cascade do |t|
    t.uuid "user_id", comment: "Userテーブルの外部キー"
    t.string "reset_password_token", comment: "パスワードリセット用トークン"
    t.datetime "reset_password_sent_at", comment: "パスワードリセット送信時刻"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reset_password_token"], name: "index_user_password_reset_requests_on_reset_password_token", unique: true
    t.index ["user_id"], name: "index_user_password_reset_requests_on_user_id", unique: true
  end

  create_table "user_registrations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "confirmation_token", null: false, comment: "確認用トークン"
    t.datetime "confirmed_at", comment: "トークン確認時刻"
    t.datetime "confirmation_sent_at", comment: "確認用トークン送信時刻"
    t.string "unconfirmed_email", comment: "未確認メールアドレス"
    t.string "email", comment: "確認済みメールアドレス"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_user_registrations_on_confirmation_token", unique: true
    t.index ["unconfirmed_email"], name: "index_user_registrations_on_unconfirmed_email", unique: true
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "admin_account_lockings", "admins"
  add_foreign_key "admin_account_trackings", "admins"
  add_foreign_key "admin_database_authentications", "admins"
  add_foreign_key "admin_password_reset_requests", "admins"
  add_foreign_key "user_account_lockings", "users"
  add_foreign_key "user_account_trackings", "users"
  add_foreign_key "user_database_authentications", "users"
  add_foreign_key "user_password_reset_requests", "users"
end
