class ChangeEventPriceFromDecimalToIntForPennies < ActiveRecord::Migration[5.1]
  def change
    change_column(:events, :price, :integer)
  end
end
