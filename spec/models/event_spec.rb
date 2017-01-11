require 'rails_helper'

describe Event do
  subject { create(:event) }

  it 'creates an event' do
    expect(build(:event).save).to eq(true)
  end

  it 'overrides blank title upon save' do
    event = create(:event, title: nil)
    expect(event.title).to eq('Untitled')
  end

  it 'validates the presence of start time' do
    event = build(:event, start_time: nil)
    expect(event.save).to eq(false)
  end

  it 'validates the presence of end time' do
    event = build(:event, end_time: nil)
    expect(event.save).to eq(false)
  end

  it 'validates the presence of event type' do
    event = build(:event, event_type: nil)
    expect(event.save).to eq(false)
  end

  it 'validates the maximum length of title' do
    event = build(:event, title: 'a' * 501)
    expect(event.save).to eq(false)
  end

  it 'validates the maximum length of title' do
    event = build(:event, notes: 'a' * 10_001)
    expect(event.save).to eq(false)
  end

  context 'chronological start and end times' do
    let(:now) { Time.current }
    let(:event) do
      build :event,
            event_type: event_type,
            start_time: start_time,
            end_time: end_time
    end

    context 'specific time' do
      let(:event_type) { 'specific_time' }

      context 'start time = end time' do
        let(:start_time) { now }
        let(:end_time) { now }

        it 'is not valid' do
          expect(event.save).to eq(false)
        end
      end

      context 'start time > end time' do
        let(:start_time) { now }
        let(:end_time) { now - 1.hour }

        it 'is not valid' do
          expect(event.save).to eq(false)
        end
      end
    end

    context 'non-specific time' do
      let(:event_type) { 'any_time' }

      context 'start time = end time' do
        let(:start_time) { now }
        let(:end_time) { now }

        it 'is valid' do
          expect(event.save).to eq(true)
        end
      end

      context 'start time > end time' do
        let(:start_time) { now }
        let(:end_time) { now - 1.hour }

        it 'is not valid' do
          expect(event.save).to eq(false)
        end
      end
    end
  end

  describe '.on_date' do
    let(:date) { Date.current }
    let(:user) { create :user }
    let(:other_user) { create :user }
    let!(:events) do
      [
        create(:event,
               user: user,
               start_time: date.beginning_of_day,
               end_time: date + 1.day),
        create(:event,
               user: user,
               start_time: date.beginning_of_day + 30.minutes,
               end_time: date + 1.day)
      ]
    end

    before do
      create(:event,
             user: user,
             start_time: date + 1.day,
             end_time: date + 2.days)
      create(:event,
             user: other_user,
             start_time: date.beginning_of_day,
             end_time: date + 1.day)
    end

    it 'returns the events of the given user on the given date sorted by start time' do
      expect(described_class.on_date(date, user)).to eq(events)
    end
  end

  describe '.upcoming' do
    let(:today) { Date.current }
    let(:now) { today + 12.hours }
    let!(:upcoming) do
      create(:event,
             event_type: :specific_time,
             start_time: today + 18.hours,
             end_time: today + 19.hours)
    end

    let(:events) do
      [
        [:all_day, today],
        [:specific_time, today.yesterday + 18.hours],
        [:specific_time, today + 6.hours],
        [:specific_time, today.tomorrow + 6.hours],
        [:specific_time, today.tomorrow + 18.hours],
        [:any_time, today]
      ].each_with_object([]) do |(event_type, start_time), array|
        array << create(:event,
                        event_type: event_type,
                        start_time: start_time,
                        end_time: start_time + 1.hour)
      end
    end

    it 'returns the upcoming event according to current time' do
      expect(described_class.upcoming(events + [upcoming], now)).to eq(upcoming)
    end
  end

  describe '#start_date' do
    it 'is the date of start time' do
      expect(subject.start_date).to eq(subject.start_time.to_date)
    end

    context 'start time is nil' do
      subject { build(:event, start_time: nil) }

      it 'is nil' do
        expect(subject.start_date).to be_nil
      end
    end
  end

  describe '#end_date' do
    it 'is the date of end time' do
      expect(subject.end_date).to eq(subject.end_time.to_date)
    end

    context 'end time is nil' do
      subject { build(:event, end_time: nil) }

      it 'is nil' do
        expect(subject.end_date).to be_nil
      end
    end
  end

  describe '#event_type?' do
    subject { create(:event, event_type: :specific_time) }

    context 'querying the same event type' do
      it 'is true' do
        expect(subject.event_type?(:specific_time)).to eq(true)
      end
    end

    context 'querying a different event type' do
      it 'is false' do
        expect(subject.event_type?(:any_time)).to eq(false)
      end
    end
  end

  describe '.by_event_type?' do
    let(:event) { create(:event, event_type: :specific_time) }
    let(:events) do
      create(:event, event_type: :all_day)
      create(:event, event_type: :any_time)
    end

    it 'returns only the events with the given event type' do
      expect(described_class.by_event_type(:specific_time)).to eq([event])
    end
  end
end
