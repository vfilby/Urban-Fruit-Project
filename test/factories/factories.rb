# Read about fixtures at http://ar.rubyonrails.org/classes/Fixtures.html
# 
# guelph_cache:
#   latitude: 43.48772
#   longitude: -80.258507
#   user: vfilby
#   location: 'Puslinch, ON, CA'
#   description: 'Guelph cache'
#   primary_tag: trillium
#   tags:
#     - poisonous
#   
# ajax_cache:
#   latitude: 43.8508553
#   longitude: -79.0203732
#   user_id: 2
#   location: 'Ajax, ON, CA'
#   description: 'Ajax cache'
#   primary_tag: trillium


FactoryGirl.define do
  
  factory :user do
    email 'test@urbanfruitproject.com' 
    name { Faker::Name.name }
    id { rand(3..3000) }
    
    factory :admin_user do
      name 'Administratorr'
      id 2
    end
  end
  
  factory :tag do
    sequence :tag do |n|
      "TagName#{n}"
    end
    meta {}
  end
  
  factory :fruit_cache do
    latitude { rand(-9000..9000).to_f/100 }
    longitude { rand(-18000..18000).to_f/100 }
    association :user, factory: :user
    association :primary_tag, factory: :tag
    
    factory :guelph_cache do
      latitude 43.48772
      longitude -80.258507
    end
    
    factory :ajax_cache do
      latitude 43.8508553
      longitude -79.0203732
    end
  end
  
  # one:
  #   user: vfilby
  #   fruit_cache: guelph_cache
  #   text: Log Entry
  # 
  # two:
  #   user: vfilby
  #   fruit_cache: guelph_cache
  #   text: MyString
  factory :log_entry do
    user
    fruit_cache
    text Faker::Lorem.sentences(2)
  end
end