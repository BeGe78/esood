# This will guess the User class
FactoryGirl.define do
  factory :admin, class: Role do
    name 'Admin'
    description 'Administration'
  end
  factory :customer, class: Role do
    name 'Customer'
    description 'Customer'
  end
end
