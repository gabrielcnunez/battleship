class Cell
  attr_reader :coordinate, :ship
  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end
  def empty?
    if @ship == nil
      true
    else
      false
    end
  end

  def place_ship(ship)
    @ship = ship
  end
  
  def fired_upon?
    @fired_upon
  end

  def fire_upon
    @fired_upon = true
    if self.empty? == false
      @ship.hit
    end
  end

  def render(show = false)
    if @fired_upon == true
      if self.empty? == true
        "M"
      elsif self.empty? == false && @ship.sunk?
        "X"
      else
        "H"
      end
    else
      if self.empty? == true
        "."
      elsif self.empty? == false && show == true
        "S"
      else
        "."
      end
    end
  end
end

# Possible option for render method:

  # def render(show = false)
  #   if show == true && @ship != nil && @fired_upon == false
  #     "S"
  #   elsif @fired_upon == false
  #     "."
  #   elsif @fired_upon == true && ship == nil
  #     "M"
  #   elsif @fired_upon == true && ship != nil
  #     "H"
  #   elsif @fired_upon == true && ship.sunk?
  #     "X"
  #   end
  # end
