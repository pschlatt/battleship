
class Cell
    attr_reader :coordinate, :ship

    def initialize(coordinate)
      @coordinate = coordinate
      @ship = nil

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
      # @binding.pry
      if @ship.health != @ship.length
        true
      else
        false
      end
    end

    def fire_upon
      @ship.hit
    end

    def render
   # binding.pry
      if binding.pry 
         #binding.pry (@ship.health != @ship.length)
        p "M"
      else
        p "."
      end
    end

end
