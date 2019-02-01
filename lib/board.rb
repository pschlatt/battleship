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
    valid_coordinate?(coordinates)
    valid_length?(ship, coordinates)
    valid_consecutive(ship, coordinates)

  end

  def valid_coordinate?(coordinates)
    if @cells.has_key?(coordinates) == true
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

  def coordinate_split(coordinates)
    coord_string_input = (coordinates*(",")).split("")
    coord_string = coord_string_input.reject do |character|
      character == ","
    end
  end


  def row_coord_ord(coordinates)
    coordinate_ord = coordinate_split(coordinates).map do |char|
      char.ord
    end
    row_ord = []
    coordinate_ord.collect.with_index do |row_coord, index|
      if index.even?
        row_ord << row_coord
      end
    end
    return row_ord
  end

  def row_ord?(coordinates)
    if row_coord_ord(coordinates).uniq.count == 1
      true
    else
      false
    end
  end


  def column_coord_ord(coordinates)
    coordinate_ord = coordinate_split(coordinates).map do |char|
      char.ord
    end
    column_ord = []
    coordinate_ord.collect.with_index do |column_coord, index|
      if index.odd?
        column_ord << column_coord
      end
    end
    return column_ord
  end

 def column_ord?(coordinates)
    if column_coord_ord(coordinates).uniq.count == 1
      true
    else
      false
    end
  end

  def row_consecutive_arr(coordinates)
    if row_ord?(coordinates)
      row_arr = column_coord_ord(coordinates)
      row_consecutive_arr = []
      row_arr.each_cons(2) do |cons|
      row_consecutive_arr << cons
      end
      row_consecutive_arr
    end
  end

  def column_consecutive_arr(coordinates)
    if column_ord?(coordinates)
      column_arr = row_coord_ord(coordinates)
      column_consecutive_arr = []
      column_arr.each_cons(2) do |cons|
      column_consecutive_arr << cons
      end
      column_consecutive_arr
    end
  end

  # def row_consecutive?(ship, coordinates)
  #   if (row_consecutive_arr[0][1]) - (row_consecutive_arr[0][0]) == 1
  #     true
  #   (rotate method here)
  # end

  # def column_consecutive?(ship, coordinates)
  #   if (column_consecutive_arr[0][1]) - (column_consecutive_arr[0][0]) == 1
  #     true
  #   (rotate method here)
  # end
# end

  def valid_consecutive(ship, coordinates)
    row_coords?(ship, coordinates)
    column_coords?(ship, coordinates)
  end


  # def row_coords?(ship, coordinates)
  #
  #   individual_coordinate =
  #   coordinates.each do |coordinate|
  #     binding.pry
  #     if coordinate[0] == "A" || coordinate[0] == "B" || coordinate[0] == "C" || coordinate[0] == "D"
  #       return true
  #     end
  #   end
  # end
  #
  # def column_coords?(ship, coordinates)
  #   coordinates.each do |coordinate|
  #     if coordinate[1] == "1" || coordinate[1] == "2" || coordinate[1] == "3" || coordinate[1] == "4"
  #       return true
  #     end
  #   end
  # end
end
