class LogEntry < ActiveRecord::Base
  belongs_to :fruit_cache
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
end
