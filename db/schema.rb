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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120707143617) do

  create_table "authorizations", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cached_browse_locations", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "parent_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.float    "latitude"
    t.float    "longitude"
  end

  create_table "cached_browse_locations_fruit_caches", :id => false, :force => true do |t|
    t.integer "cached_browse_location_id"
    t.integer "fruit_cache_id"
  end

  add_index "cached_browse_locations_fruit_caches", ["cached_browse_location_id", "fruit_cache_id"], :name => "keys_index"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "fruit_caches", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "rating"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "location"
    t.integer  "primary_tag_id"
    t.integer  "source_id"
    t.string   "source_type"
    t.text     "properties"
  end

  create_table "fruit_caches_tags", :id => false, :force => true do |t|
    t.integer "fruit_cache_id"
    t.integer "tag_id"
  end

  add_index "fruit_caches_tags", ["fruit_cache_id", "tag_id"], :name => "index_fruit_caches_tags_on_fruit_cache_id_and_tag_id"

  create_table "images", :force => true do |t|
    t.string   "caption"
    t.integer  "fruit_cache_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "user_id"
  end

  create_table "log_entries", :force => true do |t|
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "fruit_cache_id"
    t.integer  "user_id"
  end

  create_table "tags", :force => true do |t|
    t.string   "tag"
    t.integer  "parent_id"
    t.string   "meta"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "token"
  end

end
