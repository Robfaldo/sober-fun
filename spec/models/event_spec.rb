require 'rails_helper'

RSpec.describe Event, type: :model do

  describe '.price_filter' do
    let(:user) { create(:user) }

    context 'when there is a mixture of event prices in DB' do
      before(:each) do
        create_event_with_price(0, user)
        create_event_with_price(500, user)
        create_event_with_price(1500, user)
      end

      context 'when given "free"' do
        it 'returns the free event' do
          event = create_event_with_price(0, user)

          result = Event.price_filter(['free']).first

          expect(result).to include(event)
          expect(result.length).to be(2)
        end
      end
      context 'when given "under10"' do
        it 'returns the event that costs between £0 and £10' do
          event = create_event_with_price(800, user)

          result = Event.price_filter(['under10']).first

          expect(result).to include(event)
          expect(result.length).to be(2)
        end
      end
      context 'when given "ten_to_thirty"' do
        it 'returns the event that costs between £10 and £30' do
          event = create_event_with_price(2200, user)

          result = Event.price_filter(['ten_to_thirty']).first

          expect(result).to include(event)
          expect(result.length).to be(2)
        end
      end
      context 'when given a rogue parameter' do
        it 'raises error' do
          event = create_event_with_price(2200, user)

          expect{ Event.price_filter(['rogue_param']) }.to raise_error
        end
      end
    end
  end


  def create_event_with_price(price, user)
   event_params = {
      price: price,
      title: 'Test title',
      description: 'Test description',
      location: 'London',
      time: "2000-01-01 20:48:00",
      date: "2018-10-15"
    }
    event = user.events.build(event_params)
    event.save
    event
  end
end
