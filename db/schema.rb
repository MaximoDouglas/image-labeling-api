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

ActiveRecord::Schema.define(version: 2020_10_29_162518) do

  create_table "domains", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "image_classes", force: :cascade do |t|
    t.string "name"
    t.integer "domain_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["domain_id"], name: "index_image_classes_on_domain_id"
  end

  create_table "images", force: :cascade do |t|
    t.string "url"
    t.integer "image_class_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["image_class_id"], name: "index_images_on_image_class_id"
  end

end
