FactoryGirl.define do
  factory :user do
    email 'mock@mockmail.com'
    password '12341234'
    time_zone
  end

  factory :time_zone do
    time_zone 'Central Time (US & Canada)'
  end
end
