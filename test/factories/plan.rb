FactoryGirl.define do
  factory :plan1, class: Plan do
    stripe_id "Month-plan"
    name "Monthly subscription"
    amount 3000
    interval "month"
  end
  factory :plan2, class: Plan do
    stripe_id "Year-plan"
    name "Yearly subscription"
    amount 30000
    interval "year"   
  end
end  
