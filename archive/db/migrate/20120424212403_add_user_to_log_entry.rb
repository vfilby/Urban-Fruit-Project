class AddUserToLogEntry < ActiveRecord::Migration

    def self.up
      add_column :log_entries, :user_id, :integer

      # Create anonymous seed user and seed the new foreign key for
      # all the fruit_caches    
      say "Updating all existing images to reference 'Anonymouse'..."
      #debugger
      user = User.find_by_name("Anonymouse")
      LogEntry.update_all('user_id = ' + user.id.to_s)
      say "Done", true
    end

    def self.down
      remove_column :log_entries, :user_id
    end
  end