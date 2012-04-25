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

ActiveRecord::Schema.define(:version => 20120424212403) do

  create_table "authorizations", :force => true do |t|
    t.string    "provider"
    t.string    "uid"
    t.integer   "user_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer   "priority",   :default => 0
    t.integer   "attempts",   :default => 0
    t.text      "handler"
    t.text      "last_error"
    t.timestamp "run_at"
    t.timestamp "locked_at"
    t.timestamp "failed_at"
    t.string    "locked_by"
    t.string    "queue"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "fruit_caches", :force => true do |t|
    t.string    "name"
    t.string    "description"
    t.integer   "rating"
    t.float     "latitude"
    t.float     "longitude"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "user_id"
    t.string    "location"
  end

  create_table "images", :force => true do |t|
    t.string    "caption"
    t.integer   "fruit_cache_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "photo_file_name"
    t.string    "photo_content_type"
    t.integer   "photo_file_size"
    t.timestamp "photo_updated_at"
    t.integer   "user_id"
  end

  create_table "log_entries", :force => true do |t|
    t.string    "text"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "fruit_cache_id"
    t.integer   "user_id"
  end

  create_table "users", :force => true do |t|
    t.string    "email"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "name"
  end

end
