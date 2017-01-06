FactoryGirl.define do
  factory :user do
    email 'mock@mockmail.com'
    password '12341234'
    time_zone TimeZone['Central Time (US & Canada)']
  end
end
