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

ActiveRecord::Schema.define(version: 20171208233325) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "committees", force: :cascade do |t|
    t.string   "name",                 null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "formsub_committee_id"
    t.index ["name"], name: "index_committees_on_name", unique: true, using: :btree
  end

  create_table "environments", force: :cascade do |t|
    t.string   "name",              null: false
    t.string   "supervisor_name"
    t.string   "supervisor_email"
    t.boolean  "notify_supervisor"
    t.integer  "committee_id",      null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["committee_id"], name: "index_environments_on_committee_id", using: :btree
  end

  create_table "ranks", force: :cascade do |t|
    t.string   "name",         null: false
    t.integer  "committee_id", null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["committee_id"], name: "index_ranks_on_committee_id", using: :btree
  end

  create_table "statemen", force: :cascade do |t|
    t.string   "organization_id",                 null: false
    t.integer  "committee_id",                    null: false
    t.boolean  "trials_created",  default: false, null: false
    t.boolean  "tasks_created",   default: false, null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["committee_id"], name: "index_statemen_on_committee_id", using: :btree
  end

  create_table "trials", force: :cascade do |t|
    t.string   "title",                                    null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "committee_id",                             null: false
    t.date     "deadline"
    t.string   "status",               default: "pending", null: false
    t.string   "email"
    t.string   "phone_number"
    t.string   "supervisor"
    t.string   "environment"
    t.string   "stateman_trial_id"
    t.string   "private_key_digest"
    t.string   "formsub_case_id"
    t.string   "formsub_case_keyword"
    t.integer  "rank_id",                                  null: false
    t.index ["committee_id"], name: "index_trials_on_committee_id", using: :btree
    t.index ["private_key_digest"], name: "index_trials_on_private_key_digest", unique: true, using: :btree
    t.index ["rank_id"], name: "index_trials_on_rank_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "uid"
    t.string   "email"
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "environments", "committees"
  add_foreign_key "ranks", "committees"
  add_foreign_key "statemen", "committees"
  add_foreign_key "trials", "committees"
  add_foreign_key "trials", "ranks"
end
