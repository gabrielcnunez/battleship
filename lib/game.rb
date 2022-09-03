require './lib/board'
require './lib/ship'
require './lib/cell'

class Game
  attr_reader :computer_board, :player_board
  def initialize
    @computer_board = Board.new
    @player_board = Board.new
  end

  def start
    self.print_start_message
    user_input = gets.chomp
    if user_input == "p"
      self.run_game
    elsif user_input == "q"
      puts "Exiting Program..."
    else
      puts "Invalid entry, please try again"
      self.start
    end
  end

  def print_start_message
    puts "Welcome to BATTLESHIP\n" + "Enter p to play. Enter q to quit."
  end

  def random_coordinate(board)
    board.cells.keys.sample
  end

  # def random_adjacent_coords(start_coord, length)
  #   up = [start_coord]
  #   down = [start_coord]
  #   left = [start_coord]
  #   right = [start_coord]
  #   increment = 1
  #   length.times do
  #     up << (start_coord[0].ord - increment).chr + start_coord[1]
  #     down << (start_coord[0].ord + increment).chr + start_coord[1]
  #     left << start_coord[0] + (tart_coord[1] + increment)
  #     right <<
  #     increment += 1
  #   end
  # end

  # def place_computer_ships(ship)
  #   coordinates = []
  #
  # end

  def computer_ship_coordinates(ship)
   comp_coordinates = @computer_board.cells.keys.sample(ship.length)
   until @computer_board.valid_placement?(ship, comp_coordinates) == true
     comp_coordinates = @computer_board.cells.keys.sample(ship.length)
   end
   comp_coordinates
 end

 def place_computer_ships(ship)
   @computer_board.place(ship, computer_ship_coordinates(ship))
 end


end
