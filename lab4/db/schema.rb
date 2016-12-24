# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151222070418) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ar_internal_metadata", primary_key: "key", force: :cascade do |t|
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "auth_group", force: :cascade do |t|
    t.string "name", limit: 80, null: false
  end

  add_index "auth_group", ["name"], name: "auth_group_name_a6ea08ec_like", using: :btree
  add_index "auth_group", ["name"], name: "auth_group_name_key", unique: true, using: :btree

  create_table "auth_group_permissions", force: :cascade do |t|
    t.integer "group_id",      null: false
    t.integer "permission_id", null: false
  end

  add_index "auth_group_permissions", ["group_id", "permission_id"], name: "auth_group_permissions_group_id_0cd325b0_uniq", unique: true, using: :btree
  add_index "auth_group_permissions", ["group_id"], name: "auth_group_permissions_0e939a4f", using: :btree
  add_index "auth_group_permissions", ["permission_id"], name: "auth_group_permissions_8373b171", using: :btree

  create_table "auth_permission", force: :cascade do |t|
    t.string  "name",            limit: 255, null: false
    t.integer "content_type_id",             null: false
    t.string  "codename",        limit: 100, null: false
  end

  add_index "auth_permission", ["content_type_id", "codename"], name: "auth_permission_content_type_id_01ab375a_uniq", unique: true, using: :btree
  add_index "auth_permission", ["content_type_id"], name: "auth_permission_417f1b1c", using: :btree

  create_table "auth_user", force: :cascade do |t|
    t.string   "password",     limit: 128, null: false
    t.datetime "last_login"
    t.boolean  "is_superuser",             null: false
    t.string   "username",     limit: 150, null: false
    t.string   "first_name",   limit: 30,  null: false
    t.string   "last_name",    limit: 30,  null: false
    t.string   "email",        limit: 254, null: false
    t.boolean  "is_staff",                 null: false
    t.boolean  "is_active",                null: false
    t.datetime "date_joined",              null: false
  end

  add_index "auth_user", ["username"], name: "auth_user_username_6821ab7c_like", using: :btree
  add_index "auth_user", ["username"], name: "auth_user_username_key", unique: true, using: :btree

  create_table "auth_user_groups", force: :cascade do |t|
    t.integer "user_id",  null: false
    t.integer "group_id", null: false
  end

  add_index "auth_user_groups", ["group_id"], name: "auth_user_groups_0e939a4f", using: :btree
  add_index "auth_user_groups", ["user_id", "group_id"], name: "auth_user_groups_user_id_94350c0c_uniq", unique: true, using: :btree
  add_index "auth_user_groups", ["user_id"], name: "auth_user_groups_e8701ad4", using: :btree

  create_table "auth_user_user_permissions", force: :cascade do |t|
    t.integer "user_id",       null: false
    t.integer "permission_id", null: false
  end

  add_index "auth_user_user_permissions", ["permission_id"], name: "auth_user_user_permissions_8373b171", using: :btree
  add_index "auth_user_user_permissions", ["user_id", "permission_id"], name: "auth_user_user_permissions_user_id_14a6b632_uniq", unique: true, using: :btree
  add_index "auth_user_user_permissions", ["user_id"], name: "auth_user_user_permissions_e8701ad4", using: :btree

  create_table "bet_to_rides", force: :cascade do |t|
    t.integer  "bet_winner"
    t.boolean  "success"
    t.integer  "riding_id"
    t.integer  "bet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "bet_to_rides", ["bet_id"], name: "index_bet_to_rides_on_bet_id", using: :btree
  add_index "bet_to_rides", ["riding_id"], name: "index_bet_to_rides_on_riding_id", using: :btree

  create_table "bets", force: :cascade do |t|
    t.float    "value"
    t.float    "potentialWin"
    t.boolean  "sucessful"
    t.boolean  "active"
    t.integer  "client_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "bets", ["client_id"], name: "index_bets_on_client_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "ancestry"
    t.string   "img"
    t.text     "desc"
  end

  create_table "clients", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password"
    t.float    "balance"
    t.boolean  "is_super"
    t.boolean  "is_book"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "django_admin_log", force: :cascade do |t|
    t.datetime "action_time",                 null: false
    t.text     "object_id"
    t.string   "object_repr",     limit: 200, null: false
    t.integer  "action_flag",     limit: 2,   null: false
    t.text     "change_message",              null: false
    t.integer  "content_type_id"
    t.integer  "user_id",                     null: false
  end

  add_index "django_admin_log", ["content_type_id"], name: "django_admin_log_417f1b1c", using: :btree
  add_index "django_admin_log", ["user_id"], name: "django_admin_log_e8701ad4", using: :btree

  create_table "django_content_type", force: :cascade do |t|
    t.string "app_label", limit: 100, null: false
    t.string "model",     limit: 100, null: false
  end

  add_index "django_content_type", ["app_label", "model"], name: "django_content_type_app_label_76bd3d3b_uniq", unique: true, using: :btree

  create_table "django_migrations", force: :cascade do |t|
    t.string   "app",     limit: 255, null: false
    t.string   "name",    limit: 255, null: false
    t.datetime "applied",             null: false
  end

  create_table "django_session", primary_key: "session_key", force: :cascade do |t|
    t.text     "session_data", null: false
    t.datetime "expire_date",  null: false
  end

  add_index "django_session", ["expire_date"], name: "django_session_de54fa62", using: :btree
  add_index "django_session", ["session_key"], name: "django_session_session_key_c0390e0f_like", using: :btree

  create_table "ingredients_orders", id: false, force: :cascade do |t|
    t.integer "order_id"
    t.integer "ingredient_id"
  end

  add_index "ingredients_orders", ["ingredient_id"], name: "index_ingredients_orders_on_ingredient_id", using: :btree
  add_index "ingredients_orders", ["order_id"], name: "index_ingredients_orders_on_order_id", using: :btree

  create_table "knex_migrations", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.integer  "batch"
    t.datetime "migration_time"
  end

  create_table "knex_migrations_lock", id: false, force: :cascade do |t|
    t.integer "is_locked"
  end

  create_table "order_positions", force: :cascade do |t|
    t.integer "product_id"
    t.integer "order_id"
    t.decimal "price"
  end

  create_table "orders", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.text     "address"
    t.text     "comment"
    t.integer  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "polls_bet", force: :cascade do |t|
    t.float   "value",           null: false
    t.float   "potentialWin",    null: false
    t.boolean "isBetSuccessful"
    t.boolean "isActive"
    t.integer "ownerLink_id",    null: false
  end

  add_index "polls_bet", ["ownerLink_id"], name: "polls_bet_6544991b", using: :btree

  create_table "polls_bettoride", force: :cascade do |t|
    t.integer "ride_bet_winner", null: false
    t.integer "bet_id_id",       null: false
    t.integer "ride_id_id",      null: false
    t.boolean "success"
  end

  add_index "polls_bettoride", ["bet_id_id"], name: "polls_bettoride_de091468", using: :btree
  add_index "polls_bettoride", ["ride_id_id"], name: "polls_bettoride_f99d3ff7", using: :btree

  create_table "polls_bookmaker", primary_key: "client_ptr_id", force: :cascade do |t|
  end

  create_table "polls_client", force: :cascade do |t|
    t.string  "username", limit: 64,   null: false
    t.string  "email",    limit: 254,  null: false
    t.string  "password", limit: 1024, null: false
    t.float   "balance",               null: false
    t.boolean "logged"
    t.integer "name_id",               null: false
  end

  add_index "polls_client", ["name_id"], name: "polls_client_3db78b68", using: :btree

  create_table "polls_record", force: :cascade do |t|
    t.datetime "time",        null: false
    t.integer  "username_id", null: false
  end

  add_index "polls_record", ["username_id"], name: "polls_record_bbe0c9aa", using: :btree

  create_table "polls_riding", force: :cascade do |t|
    t.string  "name",              limit: 100, null: false
    t.float   "firstHorseChance"
    t.float   "secondHorseChance"
    t.integer "winner"
    t.boolean "visible"
    t.boolean "ready",                         null: false
  end

  add_index "polls_riding", ["name"], name: "polls_riding_name_921ddbf5_like", using: :btree
  add_index "polls_riding", ["name"], name: "polls_riding_name_key", unique: true, using: :btree

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "short_text"
    t.text     "long_text"
    t.string   "img"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.integer  "category_id"
    t.string   "name"
    t.string   "img"
    t.text     "desc_short"
    t.text     "desc_long"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.decimal  "price"
  end

  create_table "reviews", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.text     "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ridings", force: :cascade do |t|
    t.string   "name"
    t.float    "first"
    t.float    "second"
    t.integer  "winner"
    t.boolean  "visible"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "password"
    t.string   "email"
    t.text     "address"
    t.integer  "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "war_users", force: :cascade do |t|
    t.string   "username",        limit: 255, null: false
    t.string   "email",           limit: 255, null: false
    t.string   "timezone",        limit: 255, null: false
    t.string   "password_digest", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "war_users", ["email"], name: "war_users_email_unique", unique: true, using: :btree
  add_index "war_users", ["username"], name: "war_users_username_unique", unique: true, using: :btree

  add_foreign_key "auth_group_permissions", "auth_group", column: "group_id", name: "auth_group_permissions_group_id_b120cbf9_fk_auth_group_id"
  add_foreign_key "auth_group_permissions", "auth_permission", column: "permission_id", name: "auth_group_permiss_permission_id_84c5c92e_fk_auth_permission_id"
  add_foreign_key "auth_permission", "django_content_type", column: "content_type_id", name: "auth_permiss_content_type_id_2f476e4b_fk_django_content_type_id"
  add_foreign_key "auth_user_groups", "auth_group", column: "group_id", name: "auth_user_groups_group_id_97559544_fk_auth_group_id"
  add_foreign_key "auth_user_groups", "auth_user", column: "user_id", name: "auth_user_groups_user_id_6a12ed8b_fk_auth_user_id"
  add_foreign_key "auth_user_user_permissions", "auth_permission", column: "permission_id", name: "auth_user_user_per_permission_id_1fbb5f2c_fk_auth_permission_id"
  add_foreign_key "auth_user_user_permissions", "auth_user", column: "user_id", name: "auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id"
  add_foreign_key "bet_to_rides", "bets"
  add_foreign_key "bet_to_rides", "ridings"
  add_foreign_key "bets", "clients"
  add_foreign_key "django_admin_log", "auth_user", column: "user_id", name: "django_admin_log_user_id_c564eba6_fk_auth_user_id"
  add_foreign_key "django_admin_log", "django_content_type", column: "content_type_id", name: "django_admin_content_type_id_c4bce8eb_fk_django_content_type_id"
  add_foreign_key "polls_bet", "polls_client", column: "ownerLink_id", name: "polls_bet_ownerLink_id_b0b8fef2_fk_polls_client_id"
  add_foreign_key "polls_bettoride", "polls_bet", column: "bet_id_id", name: "polls_bettoride_bet_id_id_e4670fe9_fk_polls_bet_id"
  add_foreign_key "polls_bettoride", "polls_riding", column: "ride_id_id", name: "polls_bettoride_ride_id_id_5f4fa8bf_fk_polls_riding_id"
  add_foreign_key "polls_bookmaker", "polls_client", column: "client_ptr_id", name: "polls_bookmaker_client_ptr_id_0583cb66_fk_polls_client_id"
  add_foreign_key "polls_client", "auth_user", column: "name_id", name: "polls_client_name_id_c9c6ec78_fk_auth_user_id"
  add_foreign_key "polls_record", "auth_user", column: "username_id", name: "polls_record_username_id_9719411a_fk_auth_user_id"
end
