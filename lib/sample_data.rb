class SampleData
  class << self
    def generate
      user = new_user
      user.events.delete_all
      user.events << new_events(user.time_zone.time_zone)
      user.save!
    end

    private

    def new_user
      user = User.find_by_email('sample@data.com')
      return user if user

      User.new \
        email: 'sample@data.com',
        password: '123456',
        password_confirmation: '123456',
        time_zone_id: TimeZone.find_by_time_zone('Central Time (US & Canada)').id
    end

    def new_events(time_zone)
      Time.use_zone(time_zone) do
        events = []
        date = Date.current
        week = (date.beginning_of_week..date.end_of_week).to_a
        week.each do |day|
          events << new_events_of('all_day', [1, 2].sample, day)
          events << new_events_of('any_time',[1, 2, 3].sample, day)
          events << new_specific_time_events([3, 4, 5].sample.hours, day)
        end
        events
      end
    end

    def new_events_of(event_type, count, date)
      events = []
      event_type_id = EventType.find_by_event_type(event_type).id
      count.times do
        events << Event.new(
          title: Faker::Lorem.words.map(&:capitalize).join(' '),
          event_type_id: event_type_id,
          start_time: date.beginning_of_day,
          end_time: date.beginning_of_day
        )
      end
      events
    end

    def new_specific_time_events(interval, date)
      events = []
      event_type_id = EventType.find_by_event_type('specific_time').id
      current_time = date.beginning_of_day
      while current_time < date.end_of_day
        events << Event.new(
          title: Faker::Lorem.words.map(&:capitalize).join(' '),
          event_type_id: event_type_id,
          start_time: current_time,
          end_time: current_time + 1.hour
        )
        current_time += interval
      end
      events
    end
  end
end
