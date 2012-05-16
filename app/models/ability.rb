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
    can [:update, :delete, :destroy], FruitCache do |cache|
      cache && cache.user == current_user
    end
    
    can :create, LogEntry if current_user
    can [:update, :destroy], LogEntry do |log|
      log && log.user == current_user
    end
    
    can :create, Image if current_user
    can [:update, :delete, :destroy], Image do |image|
      image.fruit_cache.user == current_user || image.user == current_user
    end
    
    can :create, Tag if current_user
    can [:update, :delete, :destroy], Tag do |tag|
      current_user && current_user.id == 2
    end
  end
end
