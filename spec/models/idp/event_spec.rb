require 'rails_helper'

describe Idp::Event do
  describe '#event_name' do
    it 'returns humanized event type' do
      event = build(:idp_event, event_type: 'phone_changed')

      expect(event.event_name).to eq('Phone changed')
    end

    it 'returns nil if the event type is nil' do
      event = build(:idp_event, event_type: nil)

      expect(event.event_name).to eq(nil)
    end
  end

  describe '#date' do
    it 'returns the formatted created at in eastern time' do
      # 17:45 UTC in October is 1:45 PM ET
      time = DateTime.new(2018, 10, 10, 17, 45)
      formatted_time = 'October 10, 2018 at  1:45 PM'

      event = build(:idp_event, created_at: time)

      expect(event.date).to eq(formatted_time)
    end
  end
end
