require './lib/board'

class Validation

  attr_reader :cells

  def initialize(cells)
    @cells = cells
  end

  def valid_placement?(ship, coordinates)
    if !valid_coordinates?(coordinates)
      return false
    elsif !valid_length?(ship, coordinates)
      return false
    elsif !valid_consecutive?(coordinates)
      return false
    elsif !valid_coord_by_diagonal?(coordinates)
      return false
    elsif !valid_identical?(ship, coordinates)
      return false
    elsif ships_overlap?(ship, coordinates)
      return false
    end
    return true
  end

  def valid_coordinates?(coordinates)
    coordinates.each do |coordinate|
      if !valid_coordinate?(coordinate)
        return false
      end
    end
    return true
  end

  def valid_identical?(ship, coordinates)
    coordinates.uniq.count == ship.length
  end

  def valid_coordinate?(coordinate)
    if @cells.has_key?(coordinate) == true
      return true
    else
      return false
    end
  end

  def valid_consecutive?(coordinates)
    if row_consecutive?(coordinates) == true || column_consecutive?(coordinates) == true
      true
    else
      false
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
    coordinate_ord.each.with_index do |row_coord, index|
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
    row_consecutive_data = []
    if row_ord?(coordinates)
      row_arr = column_coord_ord(coordinates)
      row_arr.each_cons(2) do |cons|
        row_consecutive_data << cons
      end
    end
    row_consecutive_data
  end

  def column_consecutive_arr(coordinates)
    column_consecutive_data = []
    if column_ord?(coordinates)
      column_arr = row_coord_ord(coordinates)
      column_arr.each_cons(2) do |cons|
      column_consecutive_data << cons
      end
    end
    column_consecutive_data
  end

  def row_consecutive?(coordinates)
    row_array = row_consecutive_arr(coordinates)[0]
    if row_array
      (row_consecutive_arr(coordinates)[0][1]) - (row_consecutive_arr(coordinates)[0][0]) == 1
    else
      false
    end
  end

  def column_consecutive?(coordinates)
    column_array = column_consecutive_arr(coordinates)[0]
    if column_array
      (column_consecutive_arr(coordinates)[0][1]) - (column_consecutive_arr(coordinates)[0][0]) == 1
    end
  end

  def valid_coord_by_diagonal?(coordinates)
    if row_ord?(coordinates) || column_ord?(coordinates)
      true
    else
      false
    end
  end

  def ships_overlap?(ship, coordinates)
    cells.each do |cell|
      coordinates.each do |coordinate|
        if cell[1].empty? == false
          return true
        end
      end
    end
    return false
  end
end
