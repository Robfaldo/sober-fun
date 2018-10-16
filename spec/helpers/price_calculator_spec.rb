require_relative '../../app/helpers/events_helper'

describe EventsHelper::PriceCalculator do
  context 'When given a decimal representing pounds sterling' do
    it 'returns 1000 when given 10' do
      calculator = EventsHelper::PriceCalculator.new
      result = calculator.convert_pounds_to_pennies(10)

      expect(result).to eq(1000)
    end
    it 'returns 1050 when given 10.50' do
      calculator = EventsHelper::PriceCalculator.new
      result = calculator.convert_pounds_to_pennies(10.50)

      expect(result).to eq(1050)
    end
  end
end
