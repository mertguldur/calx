class SampleData
  class << self
    def generate
      user = new_user
      user.events.destroy_all
      user.events << new_events(user.time_zone)
      user.save!
      create_tenants(user.id, 2)
    end

    private

    def new_user
      user = User.find_by_email('sample@data.com')
      return user if user

      User.new \
        email: 'sample@data.com',
        password: '123456',
        password_confirmation: '123456',
        time_zone: 'Central Time (US & Canada)'
    end

    def create_tenants(user_id, count)
      return if AppAuthorizationRequest.where(user_id: user_id).any?
      count.times do
        tenant = Tenant.create!(access_id: SecureRandom.urlsafe_base64)
        AppAuthorizationRequest.create!(tenant_id: tenant.id, user_id: user_id)
      end
    end

    def new_events(time_zone)
      Time.use_zone(time_zone) do
        events = []
        date = Date.current
        week = (date.beginning_of_week..date.end_of_week).to_a
        week.each do |day|
          events << new_events_of(:all_day, [1, 2].sample, day)
          events << new_events_of(:any_time, [1, 2, 3].sample, day)
          events << new_specific_time_events([3, 4, 5].sample.hours, day)
        end
        events
      end
    end

    def new_events_of(event_type, count, date)
      events = []
      count.times do
        events << Event.new(
          title: Faker::Lorem.words.map(&:capitalize).join(' '),
          event_type: event_type,
          start_time: date.beginning_of_day,
          end_time: date.beginning_of_day
        )
      end
      events
    end

    def new_specific_time_events(interval, date)
      events = []
      current_time = date.beginning_of_day
      while current_time < date.end_of_day
        events << Event.new(
          title: Faker::Lorem.words.map(&:capitalize).join(' '),
          event_type: :specific_time,
          start_time: current_time,
          end_time: current_time + 1.hour
        )
        current_time += interval
      end
      events
    end
  end
end
