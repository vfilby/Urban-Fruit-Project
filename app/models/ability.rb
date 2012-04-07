class Ability
  include CanCan::Ability
  
  def initialize(user)
    if !user
      can :read, :all
    end
    
    can :read, :all
    
    can :create, FruitCache if user
    can [:update, :delete], FruitCache do |cache|
      cache && cache.user == user
    end
    
    can :manage, Image do |image|
      image.fruit_cache.user == user
    end
  end
end
