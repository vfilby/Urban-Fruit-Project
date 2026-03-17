class AddDeviceTokenToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :token, :string
    
    say 'Generating secure tokens for existing users'
    User.all.each do |user|
      user.token = Digest::SHA1.hexdigest([Time.now, rand].join)
      user.save
    end
  end
  
  def self.down
    remove_column :users, :token
  end
end
