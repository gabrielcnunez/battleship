require 'rspec'
require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/player'
require './lib/game'
require 'pry'

RSpec.describe Game do
  describe "#initialize" do
    it 'exists' do
      game = Game.new
      expect(game).to be_an_instance_of(Game)
    end
  end
  describe "#print_start_message" do
    it 'displays start message' do
      game = Game.new
      expect(game.print_start_message).to eq("Welcome to BATTLESHIP\n" +
                                            "Enter p to play. Enter q to quit.")
    end
  end
  describe "#place_computer_ships" do
    it 'can place a computer ship' do
      game = Game.new
      cruiser = Ship.new("Cruiser", 3)
      game.place_computer_ships(cruiser)
      expect(game.computer_board.ships.include?(cruiser)).to eq(true)
    end
  end
end

# print_start_message method
# game_over? method (while game_over? == false, loop gameplay?)
# start method (Welcome to Battleship! Enter p => play, q => quit)
