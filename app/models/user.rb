class User < ActiveRecord::Base
  has_many :authorizations, :dependent => :destroy
  validates_presence_of :email, :message => "can't be blank"
  validates_presence_of :name, :message => "can't be blank"

  def self.create_from_hash!(hash)
    create(:name => hash['user_info']['name'])
  end
  
  def build_authorization( omniauth )
    self.email = omniauth['user_info']['email'] if email.blank?
    authorizations.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end
end
