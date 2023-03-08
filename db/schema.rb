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

ActiveRecord::Schema[7.0].define(version: 2023_03_08_213431) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "alert_details", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "alert_type"
    t.string "description"
    t.string "from"
    t.uuid "project_id", null: false
    t.jsonb "payload"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_alert_details_on_project_id"
  end

  create_table "clients", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.uuid "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_clients_on_user_id"
  end

  create_table "notification_details", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "project_id", null: false
    t.string "sender_type", null: false
    t.uuid "sender_id", null: false
    t.string "receiver_type", null: false
    t.uuid "receiver_id", null: false
    t.string "message"
    t.uuid "notification_type_id", null: false
    t.jsonb "payload"
    t.uuid "alert_detail_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alert_detail_id"], name: "index_notification_details_on_alert_detail_id"
    t.index ["notification_type_id"], name: "index_notification_details_on_notification_type_id"
    t.index ["project_id"], name: "index_notification_details_on_project_id"
    t.index ["receiver_type", "receiver_id"], name: "index_notification_details_on_receiver"
    t.index ["sender_type", "sender_id"], name: "index_notification_details_on_sender"
  end

  create_table "notification_types", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title", null: false
    t.uuid "client_id", null: false
    t.string "secret_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_projects_on_client_id"
  end

  create_table "slack_integrations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "client_id", null: false
    t.string "workspace_name"
    t.string "api_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_slack_integrations_on_client_id"
  end

  create_table "slack_notification_receivers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "project_id", null: false
    t.string "channel_name", null: false
    t.uuid "notification_type_id", null: false
    t.uuid "slack_integration_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["notification_type_id"], name: "index_slack_notification_receivers_on_notification_type_id"
    t.index ["project_id"], name: "index_slack_notification_receivers_on_project_id"
    t.index ["slack_integration_id"], name: "index_slack_notification_receivers_on_slack_integration_id"
  end

  create_table "user_login_change_keys", id: :uuid, default: nil, force: :cascade do |t|
    t.string "key", null: false
    t.string "login", null: false
    t.datetime "deadline", null: false
  end

  create_table "user_password_reset_keys", id: :uuid, default: nil, force: :cascade do |t|
    t.string "key", null: false
    t.datetime "deadline", null: false
    t.datetime "email_last_sent", default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "user_verification_keys", id: :uuid, default: nil, force: :cascade do |t|
    t.string "key", null: false
    t.datetime "requested_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "email_last_sent", default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "status", default: 1, null: false
    t.citext "email", null: false
    t.string "first_name", null: false
    t.string "last_name"
    t.boolean "is_admin", default: false
    t.string "password_hash"
    t.index ["email"], name: "index_users_on_email", unique: true, where: "(status = ANY (ARRAY[1, 2]))"
  end

  add_foreign_key "alert_details", "projects"
  add_foreign_key "clients", "users"
  add_foreign_key "notification_details", "alert_details"
  add_foreign_key "notification_details", "notification_types"
  add_foreign_key "notification_details", "projects"
  add_foreign_key "projects", "clients"
  add_foreign_key "slack_integrations", "clients"
  add_foreign_key "slack_notification_receivers", "notification_types"
  add_foreign_key "slack_notification_receivers", "projects"
  add_foreign_key "slack_notification_receivers", "slack_integrations"
  add_foreign_key "user_login_change_keys", "users", column: "id"
  add_foreign_key "user_password_reset_keys", "users", column: "id"
  add_foreign_key "user_verification_keys", "users", column: "id"
end
