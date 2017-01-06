Given(/^today is "(.*?)"$/) do |date|
  Time.zone = @user.time_zone if @user
  Timecop.freeze Time.zone.parse(date)
end

After do
  Timecop.return
end
