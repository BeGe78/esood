# This will guess the User class
FactoryGirl.define do
  factory :user do
    name 'user'
    email 'test@gmail.com'
    password '12345678'    
  end
  factory :user1, class: User do
    name 'user1'
    email 'test1@gmail.com'
    password '12345678'    
  end
  factory :user_en, class: User  do
    name 'user_en'
    email 'test_en@gmail.com'
    password '12345678'    
  end 
  factory :user_fr, class: User  do
    name 'user_fr'
    email 'test_fr@gmail.com'
    password '12345678'    
  end  
end  