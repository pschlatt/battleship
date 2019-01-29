class Cell
    attr_reader :coordinate, :ship

    def initialize(coordinate)
      @coordinate = coordinate
      @ship = nil
    end

    def empty?
      true
    end

    def place_ship(ship)
      @ship = ship
    end

end
