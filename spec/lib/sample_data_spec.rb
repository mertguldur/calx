require 'rails_helper'
require "#{Rails.root}/lib/sample_data.rb"

describe SampleData do
  describe '.generate' do
    let(:email) { 'sample@data.com' }
    let(:time_zone) { 'Central Time (US & Canada)' }

    context 'there is no user for sample data' do
      it 'creates a new user' do
        described_class.generate
        expect(User.find_by(email: email)).to be_present
      end

      it 'creates only one user' do
        described_class.generate
        expect(User.count).to eq(1)
      end
    end

    context 'there is already a user for sample data' do
      let!(:user) { create(:user, email: 'sample@data.com') }

      it "doesn't create another user" do
        described_class.generate
        expect(User.count).to eq(1)
      end
    end

    it 'creates events for every day of the current week' do
      Time.use_zone(time_zone) do
        today = Date.current
        Timecop.freeze(today) do
          described_class.generate
          week = (today.beginning_of_week..today.end_of_week).to_a
          week.each do |date|
            events = Event.where(start_time: date.beginning_of_day..date.end_of_day)
            expect(events).to be_present
          end
        end
      end
    end

    context 'there are no app authorization requests for the user' do
      let!(:user) { create(:user, email: 'sample@data.com') }

      it 'creates app authorization requests' do
        described_class.generate
        requests = AppAuthorizationRequest.where(user_id: user.id)
        expect(requests).to be_present
      end
    end

    context 'there is already an app authorization request for the user' do
      let!(:user) { create(:user, email: 'sample@data.com') }
      let!(:tenant) { create(:tenant) }
      let!(:auth_request) { create(:app_authorization_request, user: user, tenant: tenant) }

      it 'creates app authorization requests' do
        expect { described_class.generate }.to_not change {
          AppAuthorizationRequest.where(user_id: user.id).count
        }
      end
    end
  end
end
