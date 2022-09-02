require 'rspec'
require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/player'
require 'pry'

RSpec.describe Player do
  describe "#initialize" do
    it 'exists' do
      board = Board.new
      player1 = Player.new(board)
      expect(player1).to be_an_instance_of(Player)
    end
    it 'has readable attributes' do
      board = Board.new
      player1 = Player.new(board)
      expect(player1.board).to eq(board)
    end
  end

  describe "#has_lost" do
    it 'can tell if player lost' do
      board = Board.new
      player1 = Player.new(board)
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)
      player1.board.place(cruiser, ["A1", "A2", "A3"])
      crusier.hit
      crusier.hit
      expect(player1.has_lost?).to eq(false)
      cruiser.hit
      expect(player1.has_lost?).to eq(true)
    end
  end
end
