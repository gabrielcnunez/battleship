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

  def customize_board_size(columns, rows)
    cell_names = []
    @cells = {}
    (0..rows - 1).each do |letter_num|
      letter = (65 + letter_num).chr
      columns.times do |number|
        cell_names << letter + (number + 1).to_s
      end
    end
    cell_names.each do |cell_name|
      @cells[cell_name] = Cell.new(cell_name)
    end
  end

  def valid_coordinate?(coordinate)
      @cells.key?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    if ship.length != coordinates.length
      return false
    elsif coordinates.any? {|coordinate| self.valid_coordinate?(coordinate) == false}
      return false
    elsif coordinates.any? {|coordinate| @cells[coordinate].ship != nil}
      return false
    end

    self.adjacent_to?(coordinates)
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


  def render(show = false)
    letter = []
    number = []
    @cells.keys.sort.each do |coordinate|
      letter << coordinate[0]
      number << coordinate[1].to_i
    end
    letters = letter.uniq
    numbers = number.uniq

    rendered_cells = self.render_cells(show)
    header = "  #{numbers.join(' ')} \n"
    rendered_rows = []

    letters.length.times do |row_num|
      start_cell = 0 + (numbers.length * row_num)
      end_cell = (numbers.length - 1) + (numbers.length * row_num)
      rendered_rows << "#{letters[row_num]} " + "#{rendered_cells[start_cell..end_cell].join(' ')} \n"
    end

    rendered_board = header + "#{rendered_rows.map{|row| row}.join('')}"
    return rendered_board
    # return "  1 2 3 4 \n" +
    #      "A #{rendered_cells[0..3].join(' ')} \n" +
    #      "B #{rendered_cells[4..7].join(' ')} \n" +
    #      "C #{rendered_cells[8..11].join(' ')} \n" +
    #      "D #{rendered_cells[12..15].join(' ')} \n"
  end
end
