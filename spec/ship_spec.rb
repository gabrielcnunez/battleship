require 'rspec'
require './lib/ship'

RSpec.describe do
  describe '#initialize' do
    it 'exists' do
      cruiser = Ship.new("Cruiser", 3)
      expect(cruiser).to be_an_instance_of(Ship)
    end

    it 'has readable attributes' do
      cruiser = Ship.new("Cruiser", 3)
      expect(cruiser.name).to eq("Cruiser")
      expect(cruiser.length).to eq(3)
      expect(cruiser.health).to eq(3)
    end
  end
  describe '#sunk?' do
    it 'can tell if ship has sunk' do
      cruiser = Ship.new("Cruiser", 3)
      expect(cruiser.sunk?).to eq(false)
    end
  end
  describe '#hit' do
    it 'can decrease health' do
      cruiser = Ship.new("Cruiser", 3)
      cruiser.hit
      expect(cruiser.health).to eq(2)
      expect(cruiser.sunk?).to eq(false)
      cruiser.hit
      cruiser.hit
      expect(cruiser.health).to eq(0)
      expect(cruiser.sunk?).to eq(true)
    end
  end
end
