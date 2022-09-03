require 'pry'

class Game
  attr_reader :computer_board, :player_board
  def initialize
    @computer_board = Board.new
    @player_board = Board.new
  end

  def start_game
    self.print_start_message
    user_input = gets.chomp
    if user_input == "p"
      self.run_game
    elsif user_input == "q"
      "Exiting Program"
    else
      "Invalid entry, please try again"
      self.start_game
    end
  end

  def print_start_message
    return "Welcome to BATTLESHIP\n" + "Enter p to play. Enter q to quit."
  end

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
