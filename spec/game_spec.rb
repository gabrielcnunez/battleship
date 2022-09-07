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
  describe "#computer_ship_coordinates" do
    it 'can select a random set of coordinates to place a ship' do
      game = Game.new
      cruiser = Ship.new("Cruiser", 3)
      expect(game.computer_ship_coordinates(cruiser).length).to eq(3)
      expect(game.computer_ship_coordinates(cruiser)[0]).to be_an_instance_of(String)
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

  describe "#display_boards" do
    it 'can display boards' do
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
  describe "#random_shot" do
    it 'can fire on a random coordinate' do
      game = Game.new
      shot_coordinate = game.random_shot
      expect(game.player_board.cells[shot_coordinate].fired_upon?).to eq(true)
    end
  end
  describe "#display_results" do
    it 'can display results for a miss' do
      game = Game.new
      expect {game.display_results("A1", game.computer_board)}.to output("Your shot on A1 was a miss.\n").to_stdout
    end
    it 'can display results for a hit' do
      game = Game.new
      cruiser = Ship.new("Cruiser", 3)
      game.computer_board.place(cruiser, ["A1", "A2", "A3"])
      game.computer_board.cells["A1"].fire_upon
      expect {game.display_results("A1", game.computer_board)}.to output("Your shot on A1 was a hit.\n").to_stdout
    end
    it 'can display results for a sinking' do
      game = Game.new
      cruiser = Ship.new("Cruiser", 3)
      game.player_board.place(cruiser, ["A1", "A2", "A3"])
      game.player_board.cells["A1"].fire_upon
      game.player_board.cells["A2"].fire_upon
      game.player_board.cells["A3"].fire_upon
      expect {game.display_results("A3", game.player_board)}.to output("My shot on A3 sunk a ship!\n").to_stdout
    end
  end
  describe "#game_over?" do
    it 'can tell when game is not over' do
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
      # require "pry"; binding.pry
    end
  end

  describe '#intelligent_computer' do
    it 'can find adjacent coordinates to a give coordinate' do
      game = Game.new
      last_turn_coordinate = "B2"
      expect(game.find_adjacent_coords(last_turn_coordinate)).to eq(["A2", "C2", "B1", "B3"])
    end
    it 'can find unsunk ships that have been hit' do
      game = Game.new
      cruiser = Ship.new("Cruiser", 3)
      game.player_board.place(cruiser, ["B1", "B2", "B3"])
      game.player_board.cells["B2"].fire_upon
      game.player_board.cells["C1"].fire_upon
      expect(game.unsunk_ships).to eq(["B2"])
    end
    it 'can fire shot intelligently' do
      game = Game.new
      cruiser = Ship.new("Cruiser", 3)
      game.player_board.place(cruiser, ["A1", "A2", "A3"])
      game.player_board.cells["A1"].fire_upon
      expect(game.intelligent_shot).not_to include("A3", "A4", "B2", "B3",
                                                   "B4", "C1", "C2", "C3",
                                                   "C4", "D1", "D2", "D3",
                                                   "D4")
    end
  end
end

#Method tests omitted due to requiring player input:
#start
#setup_game
#options_menu
#get_board_rows
#get_board_columns
#run_game
#place_player_ships
#player_shot
