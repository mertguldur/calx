Given(/^today is "(.*?)"$/) do |date|
  time =
    if @user
      Time.use_zone(@user.time_zone) { Time.zone.parse(date) }
    else
      Time.zone.parse(date)
    end
  Timecop.freeze(time)
end

After do
  Timecop.return
end
