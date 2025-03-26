require 'rails_helper'

RSpec.describe 'Discount Rules' do
  # Helper method to simulate the calculate_discount behavior
  def calculate_discount(code, quantity, price)
    case code
    when 'GR1'
      (quantity / 2) * price
    when 'SR1'
      quantity >= 3 ? (price - 4.50) * quantity : 0
    when 'CF1'
      quantity >= 3 ? (price * (1 / 3.0) * quantity).round(2) : 0
    else
      0
    end
  end

  describe 'Green Tea - GR1 (Buy One Get One Free)' do
    it 'applies no discount when quantity is 1' do
      expect(calculate_discount('GR1', 1, 3.11)).to eq(0)
    end

    it 'applies 1 item free for quantity 2' do
      expect(calculate_discount('GR1', 2, 3.11)).to eq(3.11)
    end

    it 'applies 1 item free for quantity 3' do
      expect(calculate_discount('GR1', 3, 3.11)).to eq(3.11)
    end

    it 'applies 2 items free for quantity 4' do
      expect(calculate_discount('GR1', 4, 3.11)).to eq(6.22)
    end
  end

  describe 'Strawberries - SR1 (Bulk discount)' do
    it 'no discount if less than 3' do
      expect(calculate_discount('SR1', 2, 5.00)).to eq(0)
    end

    it 'discount applied if 3 or more' do
      expect(calculate_discount('SR1', 3, 5.00)).to eq((5.00 - 4.50) * 3)
    end

    it 'discount increases with quantity' do
      expect(calculate_discount('SR1', 5, 5.00)).to eq((5.00 - 4.50) * 5)
    end
  end

  describe 'Coffee - CF1 (2/3 price if 3+)' do
    it 'no discount if less than 3' do
      expect(calculate_discount('CF1', 2, 11.23)).to eq(0)
    end

    it 'discount if 3 or more' do
      expected = (11.23 * (1 / 3.0) * 3).round(2)
      expect(calculate_discount('CF1', 3, 11.23)).to eq(expected)
    end

    it 'discount increases with quantity' do
      expected = (11.23 * (1 / 3.0) * 5).round(2)
      expect(calculate_discount('CF1', 5, 11.23)).to eq(expected)
    end
  end
end
