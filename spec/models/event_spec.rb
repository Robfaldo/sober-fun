require 'rails_helper'

RSpec.describe Event, type: :model do

  describe '.price_filter' do
    let(:user) { create(:user) }

    context 'when there is a mixture of event prices in DB' do
      before(:each) do
        create_event_with_price(0.00, user)
        create_event_with_price(5.00, user)
        create_event_with_price(15.00, user)
      end

      context 'when given "free"' do
        it 'returns the free event' do
          event = create_event_with_price(0.00, user)

          result = Event.price_filter(['free']).first

          expect(result).to include(event)
          expect(result.length).to be(2)
        end
      end
      context 'when given "under10"' do
        it 'returns the event that costs between £0 and £10' do
          event = create_event_with_price(8.00, user)

          result = Event.price_filter(['under10']).first

          expect(result).to include(event)
          expect(result.length).to be(2)
        end
      end
      context 'when given "ten_to_thirty"' do
        it 'returns the event that costs between £10 and £30' do
          event = create_event_with_price(22.00, user)

          result = Event.price_filter(['ten_to_thirty']).first

          expect(result).to include(event)
          expect(result.length).to be(2)
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
