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
  describe '#place_ship' do
    it 'can put ship in cells' do
      cell = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)
      cell.place_ship(cruiser)
      expect(cell.ship).to eq(cruiser)
      expect(cell.empty?).to eq(false)
    end
  end
  describe '#fired_upon?' do
    it 'can tell if cell is fired upon' do
      cell = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)
      cell.place_ship(cruiser)
      expect(cell.fired_upon?).to eq(false)
    end
  end
  describe '#fire_upon' do
    it 'can fire upon a cell' do
      cell = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)
      cell.place_ship(cruiser)
      cell.fire_upon
      expect(cell.ship.health).to eq(2)
      expect(cell.fired_upon?).to eq(true)
    end
  end
  describe '#render' do
    it 'can render default status of cell' do
      cell_1 = Cell.new("B4")
      expect(cell_1.render).to eq(".")
    end

    it 'can change status of cell' do
      cell_1 = Cell.new("B4")
      expect(cell_1.render).to eq(".")
      cell_1.fire_upon
      expect(cell_1.render).to eq("M")
    end

    it 'can render default ship cell' do
      cell_2 = Cell.new("C3")
      cruiser = Ship.new("Cruiser", 3)
      cell_2.place_ship(cruiser)
      expect(cell_2.render).to eq(".")
    end

    it 'can show ship with optional argument' do
      cell_2 = Cell.new("C3")
      cruiser = Ship.new("Cruiser", 3)
      cell_2.place_ship(cruiser)
      expect(cell_2.render(true)).to eq("S")
    end

    it 'can render a hit' do
      cell_2 = Cell.new("C3")
      cruiser = Ship.new("Cruiser", 3)
      cell_2.place_ship(cruiser)
      cell_2.fire_upon
      expect(cell_2.render).to eq("H")
    end

    it 'can show a sunken ship' do
      cell_2 = Cell.new("C3")
      cruiser = Ship.new("Cruiser", 3)
      cell_2.place_ship(cruiser)
      cell_2.fire_upon
      expect(cell_2.render).to eq("H")
      expect(cruiser.sunk?).to eq(false)
      cruiser.hit
      cruiser.hit
      expect(cruiser.sunk?).to eq(true)
      expect(cell_2.render).to eq("X")
    end
  end
end
