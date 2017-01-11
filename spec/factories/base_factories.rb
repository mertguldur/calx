FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "mock#{n}@mockmail.com"
    end
    password '12341234'
    time_zone TimeZone['Central Time (US & Canada)']
  end

  factory :event do
    title 'Breakfast'
    start_time Time.current
    end_time 1.hour.from_now
    event_type EventType[:specific_time]
    user
  end

  factory :tenant do
    sequence :access_id do |n|
      "foo#{n}"
    end
  end

  factory :app_authorization_request do
    user
    tenant
  end

  factory :app_authorization_response do
    app_authorization_request
    app_authorization_response_type AppAuthorizationResponseType[:grant]
  end
end
