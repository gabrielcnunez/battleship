require 'rspec'
require './lib/board'
require './lib/ship'

RSpec.describe do
  describe '#initialize' do
    it "exists" do
      board = Board.new
      expect(board).to be_an_instance_of(Board)
    end
    it "has readable cells attribute" do
      board = Board.new
      expect(board.cells).to be_a(Hash)
      expect(board.cells.length).to eq(16)
      board.cells.values.each do |cell|
        expect(cell).to be_an_instance_of(Cell)
      end
    end
  end

  describe '#valid_coordinate?' do
    it "can tell if a coordinate is on the board" do
      board = Board.new
      expect(board.valid_coordinate?("A1")).to eq(true)
      expect(board.valid_coordinate?("D4")).to eq(true)
    end
    it "can tell if a coordinate is off the board" do
      board = Board.new
      expect(board.valid_coordinate?("A5")).to eq(false)
      expect(board.valid_coordinate?("E1")).to eq(false)
      expect(board.valid_coordinate?("A22")).to eq(false)
    end
  end

  describe '#valid_placement?' do
    it "can determine if ship length isn't equal to number of coordinates" do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)
      expect(board.valid_placement?(cruiser, ["A1", "A2"])).to eq(false)
      expect(board.valid_placement?(submarine, ["A2", "A3", "A4"])).to eq(false)
    end
    it "can determine if ship coordinates aren't consecutive" do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)
      expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to eq(false)
      expect(board.valid_placement?(submarine, ["A1", "C1"])).to eq(false)
    end
    it "can determine if ship coordinates are descending" do
      #could look into making descending coordinates also valid later
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)
      expect(board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to eq(false)
      expect(board.valid_placement?(submarine, ["C1", "B1"])).to eq(false)
    end
    it "can determine that ship coordinates can't be diagonal" do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)
      expect(board.valid_placement?(cruiser, ["A1", "B2", "C3"])).to eq(false)
      expect(board.valid_placement?(submarine, ["C2", "D3"])).to eq(false)
    end
    it "can determine when ship placement is valid" do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)
      expect(board.valid_placement?(submarine, ["A1", "A2"])).to eq(true)
      expect(board.valid_placement?(cruiser, ["B1", "C1", "D1"])).to eq(true)
    end
  end
end
