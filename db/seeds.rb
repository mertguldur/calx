%w(specific_time all_day any_time).each do |event_type|
  EventType.find_or_create_by!(event_type: event_type)
end

%w(grant revoke).each do |response_type|
  AppAuthorizationResponseType.find_or_create_by!(app_authorization_response_type: response_type)
end

ActiveSupport::TimeZone.all.map(&:name).each do |time_zone|
  TimeZone.find_or_create_by!(time_zone: time_zone)
end
