class Game
  
  def initialize
    @computer_board = nil
    @player_board = nil
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

  def print_start_message
    return "Welcome to BATTLESHIP\n" + "Enter p to play. Enter q to quit." 
  end

end