FactoryGirl.define do
  factory :plan1, class: Plan do
    stripe_id 'month-plan'
    name 'Monthly subscription'
    amount 100
    interval 'month'
  end
  factory :plan2, class: Plan do
    stripe_id 'year-plan'
    name 'Yearly subscription'
    amount 900
    interval 'year'
  end
end
