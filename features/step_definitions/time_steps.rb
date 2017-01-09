Given(/^today is "(.*?)"$/) do |date|
  Time.zone = @user.time_zone if @user
  Timecop.freeze Time.zone.parse(date)
end

Given(/^time zone is set to user's time zone$/) do
  Time.zone = @user.time_zone
end

After do
  Timecop.return
end
