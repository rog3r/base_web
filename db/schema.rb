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

ActiveRecord::Schema.define(version: 20150821193763) do

  create_table "abilities", force: :cascade do |t|
    t.string   "domain",     index: {name: "index_abilities_on_domain_and_ability", with: ["ability"]}
    t.string   "ability"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",       index: {name: "index_roles_on_name"}
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "abilities_roles", force: :cascade do |t|
    t.integer  "ability_id", index: {name: "fk__abilities_roles_ability_id"}, foreign_key: {references: "abilities", name: "fk_abilities_roles_ability_id", on_update: :no_action, on_delete: :no_action}
    t.integer  "role_id",    index: {name: "fk__abilities_roles_role_id"}, foreign_key: {references: "roles", name: "fk_abilities_roles_role_id", on_update: :no_action, on_delete: :no_action}
    t.datetime "created_at"
    t.datetime "updated_at"
  end
  add_index "abilities_roles", ["ability_id", "role_id"], name: "index_abilities_roles_on_ability_id_and_role_id"

  create_table "permissions_roles", force: :cascade do |t|
    t.integer "permission_id", index: {name: "fk__permissions_roles_permission_id"}, foreign_key: {references: "permissions", name: "fk_permissions_roles_permission_id", on_update: :no_action, on_delete: :no_action}
    t.integer "role_id",       index: {name: "fk__permissions_roles_role_id"}, foreign_key: {references: "roles", name: "fk_permissions_roles_role_id", on_update: :no_action, on_delete: :no_action}
  end
  add_index "permissions_roles", ["permission_id", "role_id"], name: "index_permissions_roles_on_permission_id_and_role_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false, index: {name: "index_users_on_email", unique: true}
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token",   index: {name: "index_users_on_reset_password_token", unique: true}
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "locale"
    t.boolean  "locked",                 default: false
    t.string   "name"
    t.string   "confirmation_token",     index: {name: "index_users_on_confirmation_token", unique: true}
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",        default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
  end

  create_table "roles_users", id: false, force: :cascade do |t|
    t.integer "role_id", index: {name: "fk__roles_users_role_id"}, foreign_key: {references: "roles", name: "fk_roles_users_role_id", on_update: :no_action, on_delete: :no_action}
    t.integer "user_id", index: {name: "fk__roles_users_user_id"}, foreign_key: {references: "users", name: "fk_roles_users_user_id", on_update: :no_action, on_delete: :no_action}
  end
  add_index "roles_users", ["role_id", "user_id"], name: "index_roles_users_on_role_id_and_user_id"

end
