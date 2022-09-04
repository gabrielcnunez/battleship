require './lib/board'
require './lib/ship'
require './lib/cell'

class Game
  attr_reader :computer_board, :player_board
  def initialize
    # @computer_board = Board.new
    # @player_board = Board.new
  end

  def start
    self.print_start_message
    user_input = gets.chomp
    if user_input == "p"
      self.setup_game
      self.run_game
    elsif user_input == "q"
      puts "Exiting Program..."
    else
      puts "Invalid entry, please try again"
      self.start
    end
  end

  def setup_game
    @computer_board = Board.new
    @player_board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    self.place_computer_ships(cruiser)
    submarine = Ship.new("Submarine", 2)
    self.place_computer_ships(submarine)
    self.place_player_ships
  end

  def run_game
    play_again = nil
    until play_again == false
      until self.game_over?
        self.display_game_boards
        self.player_shot
        self.computer_shot
      end
      puts "Play again? (Y/N)"
      restart_input = gets.chomp
      if restart_input.downcase == "y"
        play_again = true
        self.setup_game
      elsif restart_input.downcase == "n"
        puts "Exiting Program..."
        play_again = false
      end
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

  def computer_shot
    computer_fire = @player_board.cells.keys.sample

    until @player_board.cells[computer_fire].fired_upon? == false
      computer_fire = @player_board.cells.keys.sample
    end
    @player_board.cells[computer_fire].fire_upon
    self.display_results(computer_fire, @player_board)
    computer_fire
  end

  def display_game_boards
    puts "=============COMPUTER BOARD============= \n"
    puts @computer_board.render
    puts "==============PLAYER BOARD============== \n"
    puts @player_board.render(true)
    puts "======================================== \n"
  end


  def place_player_ships
    puts "I have laid out my ships on the grid.\n" +
         "You now need to lay out your two ships.\n"+
         "The Cruiser is three units long and the Submarine is two units long.\n" +
         @player_board.render +
         "Enter the squares for the Cruiser (3 spaces):\n"
    cruiser = Ship.new("Cruiser", 3)
    cruiser_placed = false
    while cruiser_placed == false
      cruiser_input = gets.chomp.split(",").map(&:strip)
      if @player_board.valid_placement?(cruiser, cruiser_input)
        @player_board.place(cruiser, cruiser_input)
        cruiser_placed = true
      else
        puts "Those are invalid coordinates. Please try again:"
      end
    end

    puts @player_board.render(true)

    puts "Enter the squares for the Submarine (2 spaces):"
    submarine = Ship.new("Submarine", 2)
    sub_placed = false
    until sub_placed == true
      sub_input = gets.chomp.split(",").map(&:strip)
      if @player_board.valid_placement?(submarine, sub_input)
        @player_board.place(submarine, sub_input)
        sub_placed = true
      else
        puts "Those are invalid coordinates. Please try again:"
      end
    end
  end

  def player_shot
    puts "Enter the coordinate for your shot:"
    valid_shot = false
    until valid_shot == true
      shot_input = gets.chomp
      if @computer_board.valid_coordinate?(shot_input) && @computer_board.cells[shot_input].fired_upon? == false
        @computer_board.cells[shot_input].fire_upon
        valid_shot = true
        self.display_results(shot_input, @computer_board)
      elsif @computer_board.valid_coordinate?(shot_input) && @computer_board.cells[shot_input].fired_upon?
        puts "Coordinate has already been fired upon, enter another coordinate:"
      else
        puts "Please enter a valid coordinate:"
      end
    end
  end

  def display_results(shot, board)
    if board == @computer_board
      if @computer_board.cells[shot].empty?
        result = "was a miss."
      elsif @computer_board.cells[shot].ship.sunk?
        result = "sunk a ship!"
      else
        result = "was a hit."
      end
      puts "Your shot on #{shot} #{result}"

    elsif board == @player_board
      if @player_board.cells[shot].empty?
        result = "was a miss."
      elsif @player_board.cells[shot].ship.sunk?
        result = "sunk a ship!"
      else
        result = "was a hit."
      end
      puts "My shot on #{shot} #{result}"
    end
  end

  def game_over?
    self.display_game_over_message
    self.computer_lost? || self.player_lost?
  end

  def computer_lost?
    @computer_board.ships.all? {|ship| ship.sunk?}
  end

  def player_lost?
    @player_board.ships.all? {|ship| ship.sunk?}
  end

  def display_game_over_message
    if self.computer_lost?
      puts "You won!"
    elsif self.player_lost?
      puts "I won!"
    end
  end
end
