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

ActiveRecord::Schema.define(version: 20171227115501) do

  create_table "db_mailer_templates", force: :cascade do |t|
    t.string "db_mailer_class", limit: 64, null: false
    t.string "subject", limit: 80, null: false
    t.string "from", limit: 64, null: false
    t.string "to", limit: 64, null: false
    t.text "body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["db_mailer_class"], name: "index_db_mailer_templates_on_db_mailer_class", unique: true
  end

end
