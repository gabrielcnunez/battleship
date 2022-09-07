require 'rspec'
require './lib/board'
require './lib/ship'
require './lib/cell'

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

  describe '#customize_board_size' do
    it "can customize board size" do
      board = Board.new
      board.customize_board_size(5, 5)
      expect(board.cells.length).to eq(25)
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
    # #Decided to allow for descending coordinates (or any order, really)
    # it "can determine if ship coordinates are descending" do
    #   board = Board.new
    #   cruiser = Ship.new("Cruiser", 3)
    #   submarine = Ship.new("Submarine", 2)
    #   expect(board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to eq(false)
    #   expect(board.valid_placement?(submarine, ["C1", "B1"])).to eq(false)
    # end
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

  describe "#place_ships" do
    it 'an place a ship on the board' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      board.place(cruiser, ["A1", "A2", "A3"])
      cell_1 = board.cells["A1"]
      cell_2 = board.cells["A2"]
      cell_3 = board.cells["A3"]
      expect(cell_1.ship).to eq(cruiser)
      expect(cell_2.ship).to eq(cruiser)
      expect(cell_3.ship).to eq(cruiser)
    end
    it 'can read same ship on different cells' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      board.place(cruiser, ["A1", "A2", "A3"])
      cell_1 = board.cells["A1"]
      cell_2 = board.cells["A2"]
      cell_3 = board.cells["A3"]
      expect(cell_3.ship).to eq(cell_2.ship)
    end
  end
  describe "overlapping_ships" do
    it 'can tell if ship placement will overlap' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      board.place(cruiser, ["A1", "A2", "A3"])
      submarine = Ship.new("Submarine", 2)
      expect(board.valid_placement?(submarine, ["A1", "B1"])).to eq(false)
    end
  end

  describe "board_render" do
    it 'can render a computer board' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      board.place(cruiser, ["A1", "A2", "A3"])
      expect(board.render).to eq("  1 2 3 4 \n" +
                                 "A . . . . \n" +
                                 "B . . . . \n" +
                                 "C . . . . \n" +
                                 "D . . . . \n")
    end
    it 'can render a player board' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      board.place(cruiser, ["A1", "A2", "A3"])
      expect(board.render(true)).to eq("  1 2 3 4 \n" +
                                       "A S S S . \n" +
                                       "B . . . . \n" +
                                       "C . . . . \n" +
                                       "D . . . . \n")
    end
    it 'can render a custom player board' do
      board = Board.new
      board.customize_board_size(5, 5)
      cruiser = Ship.new("Cruiser", 3)
      board.place(cruiser, ["A1", "A2", "A3"])
      expect(board.render(true)).to eq("  1 2 3 4 5 \n" +
                                       "A S S S . . \n" +
                                       "B . . . . . \n" +
                                       "C . . . . . \n" +
                                       "D . . . . . \n" +
                                       "E . . . . . \n")
    end
    it 'can render a custom computer board' do
      board = Board.new
      board.customize_board_size(5, 6)
      cruiser = Ship.new("Cruiser", 3)
      board.place(cruiser, ["A1", "A2", "A3"])
      expect(board.render).to eq("  1 2 3 4 5 \n" +
                                 "A . . . . . \n" +
                                 "B . . . . . \n" +
                                 "C . . . . . \n" +
                                 "D . . . . . \n" +
                                 "E . . . . . \n" +
                                 "F . . . . . \n")
    end
  end
end
