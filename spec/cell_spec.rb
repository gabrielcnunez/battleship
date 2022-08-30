require 'rspec'
require './lib/ship'
require './lib/cell'

RSpec.describe do
  describe '#initialize' do
    it 'exists' do
      cell = Cell.new("B4")
      expect(cell).to be_an_instance_of(Cell)
    end
    it 'has readable attributes' do
      cell = Cell.new("B4")
      expect(cell.coordinate).to eq("B4")
      expect(cell.ship).to eq(nil)
    end
  end
  describe '#empty?' do
    it 'can tell if cell is empty' do
      cell = Cell.new("B4")
      expect(cell.empty?).to eq(true)
    end
  end
end
