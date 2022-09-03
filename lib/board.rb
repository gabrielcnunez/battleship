require 'pry'

class Board
  attr_reader :cells, :ships
  def initialize
  @cells = {
      "A1" => Cell.new("A1"),
      "A2" => Cell.new("A2"),
      "A3" => Cell.new("A3"),
      "A4" => Cell.new("A4"),
      "B1" => Cell.new("B1"),
      "B2" => Cell.new("B2"),
      "B3" => Cell.new("B3"),
      "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"),
      "C2" => Cell.new("C2"),
      "C3" => Cell.new("C3"),
      "C4" => Cell.new("C4"),
      "D1" => Cell.new("D1"),
      "D2" => Cell.new("D2"),
      "D3" => Cell.new("D3"),
      "D4" => Cell.new("D4")
  }
  @ships = []
  end

  def valid_coordinate?(coordinate)
      @cells.key?(coordinate)
  end

  # def consecutive_letters
  # end

  # def consecutive_numbers(numbers)
  # end

  def valid_placement?(ship, coordinates)
    if ship.length != coordinates.length
      return false
    elsif coordinates.any? {|coordinate| self.valid_coordinate?(coordinate) == false}
      return false
    elsif coordinates.any? {|coordinate| @cells[coordinate].ship != nil}
      return false
    end

    self.adjacent_to?(coordinates)

    # letter = []
    # number = []
    #
    # coordinates.each do |coordinate|
    #   letter << coordinate[0].ord
    #   number << coordinate[1].to_i
    # end
    # if number.uniq.size == 1 && letter.each_cons(2).all? {|a, b| b == a + 1 }
    #     true
    # elsif letter.uniq.size == 1 && number.each_cons(2).all? {|a, b| b == a + 1 }
    #     true
    # else
    #     false
    # end
  end

  def adjacent_to?(coordinates)
    letter = []
    number = []
    coordinates.sort.each do |coordinate|
      letter << coordinate[0].ord
      number << coordinate[1].to_i
    end
    if number.uniq.size == 1 && letter.each_cons(2).all? {|a, b| b == a + 1 }
        true
    elsif letter.uniq.size == 1 && number.each_cons(2).all? {|a, b| b == a + 1 }
        true
    else
        false
    end
  end

  def place(ship, placement)
    @ships << ship
    placement.each do |coordinate|
      @cells[coordinate].place_ship(ship)
    end
  end

  def render_cells(show = false)
    if show == false
      @cells.values.map do |cell|
        cell.render
      end
    else
      @cells.values.map do |cell|
        cell.render(true)
      end
    end
  end

  # def print_render_line(rendered_cells)
  #   4.times do
  #     print " "
  #   end
  #
  # end

  def render(show = false)
    rendered_cells = self.render_cells(show)
    # puts "A #{rendered_cells[0..3].each{|cell| print "#{cell}"}}"
    return "  1 2 3 4 \n" +
         "A #{rendered_cells[0..3].join(' ')} \n" +
         "B #{rendered_cells[4..7].join(' ')} \n" +
         "C #{rendered_cells[8..11].join(' ')} \n" +
         "D #{rendered_cells[12..15].join(' ')} \n"
  end
end
