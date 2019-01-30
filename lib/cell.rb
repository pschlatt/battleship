
class Cell

  attr_reader :coordinate,
              :ship

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

  def place_ship(ship_type)
    @ship = ship_type
    #binding.pry
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    @fired_upon = true
    if @ship != nil
      @ship.hit
    end
  end

  def render(not_hidden = false)
    if @ship != nil && @fired_upon == true
      return "H"
    elsif @ship == nil && @fired_upon == true
      return "M"
    elsif @ship != nil && not_hidden == true
      return "S"
    else
      return "."
    end
  end
end
