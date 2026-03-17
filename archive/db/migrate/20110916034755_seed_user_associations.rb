class SeedUserAssociations < ActiveRecord::Migration
  def self.up
    add_column :fruit_caches, :user_id, :integer
    
    # Create anonymous seed user and seed the new foreign key for
    # all the fruit_caches
    say "Adding 'Anonymouse' user"
    user = User.create :name => 'Anonymouse', :email => 'anonymouse@urbanfruitproject.com'
    user.save!
    say "Done", true
    
    say "Updating all existing caches to reference 'Anonymouse'"
    #debugger
    FruitCache.update_all('user_id = ' + user.id.to_s)
    say "Done", true
  end

  def self.down
    remove_column :fruit_caches, :user_id
    
    user = User.find_by_name("Anonymouse")
    if !user.nil?
      say "Removing 'Anonymouse' user"
      user.destroy
      say "Done", true
    end
  end
end