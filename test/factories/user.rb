# This will guess the User class
FactoryGirl.define do
  factory :user do
    name 'user'
    email 'test@gmail.com'
    password '12345678'    
  end
  factory :user1 do
    name 'user1'
    email 'test1@gmail.com'
    password '12345678'    
  end
end  
