require './lib/validation'

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
    @validation = Validation.new(@cells)
  end

  # def custom_board_keys
  #   print "Enter a number from 4 to 25"
  #   arr_key = gets.chomp
  #   if arr_key > 25
  #     print "That's too large for this board"
  #     system('clear')
  #     sleep(2)
  #     custom_board_keys
  #   end
  #   arr = (*1..arr_key)
  #   arr.length
  #
  # end

  def validation
    @validation
  end

  def valid_coordinate?(coordinate)
    @validation.valid_coordinate?(coordinate)
  end

  def valid_placement?(ships, coordinate)
    @validation.valid_placement?(ships, coordinate)
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
    output = "\n"
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
    print "\n"
  end
end
