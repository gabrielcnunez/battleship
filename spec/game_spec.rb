require 'rspec'
require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/player'
require './lib/game'

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
      expect { game.print_start_message }.to output("Welcome to BATTLESHIP\n" +
                                                    "Enter p to play. Enter q to quit.\n").to_stdout
    end
  end
  describe "#place_computer_ships" do
    it 'can place a computer ship' do
      # computer needs to pick a random coordinate,
      game = Game.new
      cruiser = Ship.new("Cruiser", 3)
      game.place_computer_ships(cruiser)
      # require "pry"; binding.pry
      expect(game.computer_board.ships.include?(cruiser)).to eq(true)
    end
  end
  describe "#random_coordinate" do
    it 'can select a random coordinate' do
      game = Game.new
      random_coord = game.random_coordinate(game.computer_board)
      expect(game.player_board.cells[random_coord]).to be_an_instance_of(Cell)
    end
  end
  describe "#place_player_ships" do
    xit 'can prompt player for ship placement' do
      game = Game.new
      expect {game.place_player_ships}.to output("I have laid out my ships on the grid.\n" +
                                                 "You now need to lay out your two ships.\n" +
                                                 "The Cruiser is three units long and the Submarine is two units long.\n" +
                                                 "  1 2 3 4 \n" +
                                                 "A . . . . \n" +
                                                 "B . . . . \n" +
                                                 "C . . . . \n" +
                                                 "D . . . . \n" +
                                                 "Enter the squares for the Cruiser (3 spaces):\n").to_stdout
    end
  end
  describe "#display_boards" do
    xit 'can display boards' do
      game = Game.new
      game.display_game_boards
      # binding.pry
      expect {game.display_game_boards}.to output("=============COMPUTER BOARD============= \n" +
                                             "  1 2 3 4 \n" +
                                             "A . . . . \n" +
                                             "B . . . . \n" +
                                             "C . . . . \n" +
                                             "D . . . . \n" +
                                             "==============PLAYER BOARD============== \n" +
                                             "  1 2 3 4 \n" +
                                             "A . . . . \n" +
                                             "B . . . . \n" +
                                             "C . . . . \n" +
                                             "D . . . . \n" +
                                             "======================================== \n").to_stdout
    end
  end
  describe "#player_shot" do
    xit 'asks for player shot coordinate' do
      game = Game.new
      expect {game.player_shot}.to output("Enter the coordinate for your shot:\n")
    end
  end
  describe "#computer_shot" do
    it 'can fire on a random coordinate' do
      game = Game.new
      shot_coordinate = game.computer_fire
      expect(game.player_board.cells[shot_coordinate].fired_upon?).to eq(true)
    end
  end
  describe "#display_results" do

  end
  describe "#game_over?" do
    xit 'can tell when game is not over' do
      game = Game.new
      cruiser = Ship.new("Cruiser", 3)
      cruiser_2 = Ship.new("Cruiser", 3)
      game.place_computer_ships(cruiser)
      game.player_board.place(cruiser_2, ["A1", "A2", "A3"])
      expect(game.game_over?).to eq(false)
    end
    it 'can tell when game is over' do
      game = Game.new
      cruiser = Ship.new("Cruiser", 3)
      cruiser_2 = Ship.new("Cruiser", 3)
      game.place_computer_ships(cruiser)
      game.player_board.place(cruiser_2, ["A1", "A2", "A3"])
      cruiser.hit
      cruiser.hit
      cruiser.hit
      require "pry"; binding.pry
    end
  end
end

# print_start_message method
# game_over? method (while game_over? == false, loop gameplay?)
# start method (Welcome to Battleship! Enter p => play, q => quit)
