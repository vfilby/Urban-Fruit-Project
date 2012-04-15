class Ability
  include CanCan::Ability
  
  def initialize(current_user)
    if !current_user
      can :read, :all
    end
    
    can :read, :all
    
    can :create, User
    can [:profile, :update, :delete, :destroy], User do |user|
      user == current_user
    end
    
    can :create, FruitCache if current_user
    can [:update, :delete], FruitCache do |cache|
      cache && cache.user == current_user
    end
    
    can :create, Image if current_user
    can [:update, :delete], Image do |image|
      image.fruit_cache.user == current_user
    end
  end
end
