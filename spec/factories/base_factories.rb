FactoryGirl.define do
  factory :user do
    email 'mock@mockmail.com'
    password '12341234'
    time_zone TimeZone['Central Time (US & Canada)']
  end

  factory :event do
    title 'Breakfast'
    start_time Time.current
    end_time 1.hour.from_now
    event_type EventType[:specific_time]
  end

  factory :tenant do
    access_id 'foo'
  end

  factory :app_authorization_request

  factory :app_authorization_response do
    app_authorization_response_type AppAuthorizationResponseType[:grant]
  end
end
