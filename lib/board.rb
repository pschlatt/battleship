class Board

  attr_reader :cells
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
  end

  def valid_placement?(ship, coordinates)
    valid_length?(ship, coordinates)
    sort_length_coord?(ship, coordinates)
    sort_width_coord?(ship, coordinates)
  end

  def valid_coordinate?(coordinate)
    if @cells.has_key?(coordinate) == true
      return true
    else
      return false
    end
  end

  def valid_length?(ship, coordinates)
    if ship.length == coordinates.count
      true
    else
      false
    end
  end

  def sort_length_coord(ship, coordinates)
    length_coordinates = []
    width_coordinates = []
    coordinates.each do |coordinate|
      if coordinate[0] == "A" || coordinate[0] == "B" || coordinate[0] == "C" || coordinate[0] == "D"
        length_coordinates << coordinate
      elsif coordinate[1] == "1" || coordinate[1] == "2" || coordinate[1] == "3" || coordinate[1] == "4"
        width_coordinates << coordinate
      end
    end
    binding.pry
  end

  def sort_width_coord(ship, coordinates)
end
