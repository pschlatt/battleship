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

  def place(ship, coordinates)
    cells.each do |cell|
      coordinates.each do |coordinate|
        if cell[0] == coordinate
          cell[1].place_ship(ship)
        end
      end
    end
  end


  def valid_placement?(ship, coordinates)
    valid_coordinate?(coordinates)
    valid_length?(ship, coordinates)
    valid_consecutive?(coordinates)
    valid_diagonal?(coordinates)
    ships_overlap?(ship, coordinates)

  end

  def valid_consecutive?(coordinates)
    if row_consecutive?(coordinates) == true || column_consecutive(coordinates) == true
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

  def valid_coordinate?(coordinates)
    if @cells.has_key?(coordinates) == true
      return true
    else
      return false
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
    if row_ord?(coordinates)
      row_arr = column_coord_ord(coordinates)
      row_consecutive_data = []
      row_arr.each_cons(2) do |cons|
      row_consecutive_data << cons
      end
      row_consecutive_data
    end
  end

  def column_consecutive_arr(coordinates)
    if column_ord?(coordinates)
      column_arr = row_coord_ord(coordinates)
      column_consecutive_data = []
      column_arr.each_cons(2) do |cons|
      column_consecutive_data << cons
      end
      column_consecutive_data
    end
  end

  def row_consecutive?(coordinates)
    (row_consecutive_arr(coordinates)[0][1]) - (row_consecutive_arr(coordinates)[0][0]) == 1

  end

  def column_consecutive?(coordinates)
    (column_consecutive_arr(coordinates)[0][1]) - (column_consecutive_arr(coordinates)[0][0]) == 1
  end

  def valid_diagonal?(coordinates)
    if row_ord?(coordinates) || column_ord?(coordinates)
      true
    else
      false
    end
  end

  def ships_overlap(ship, coordinates)
    cells.each do |cell|
      coordinates.each do |coordinate|
        if cell[0] == coordinate
          return true
        else
          return false
        end
      end
    end
  end

  def render_master
    render_arr = []
    render = {}
    cells.group_by do |cell|
      render_arr << cell[0]
    end
    render = render_arr.group_by do |coord|
      coord[0]
    end
  end

  def render(not_hidden = false)
    render_header
    render_body(not_hidden)
    print "\n"
  end

  def render_body(not_hidden)
    print "\n"
    render_master.keys.each do |key|
      print "#{key} "
      @cells.each_value do |value|
        if value.coordinate[0] == key
          print "#{value.render(not_hidden)} "
        end
      end
      print "\n"
    end
  end

  def render_header
    print "  "
    render_master.values[0].each do |column_index|
      print "#{column_index[1]} "
    end
  end
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
