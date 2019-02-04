require 'minitest/autorun'
require 'minitest/pride'
require './lib/validation'
require './lib/board'
require './lib/cell'
require './lib/ship'
require 'pry'

class BoardTest < Minitest::Test

  def setup
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @validation = Validation.new
  end

  def test_validation_exists
    assert_instance_of Validation, @board.validation
  end

  def test_validation_has_cells
    assert_equal ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"], @validation.cells.keys
  end

  def test_board_has_valid_coordinates
    assert_equal true, @validation.valid_coordinate?("A2")
    assert_equal true, @validation.valid_coordinate?("A1")
    assert_equal false, @validation.valid_coordinate?("A5")
    assert_equal false, @validation.valid_coordinate?("E1")
    assert_equal false, @validation.valid_coordinate?("A22")
    assert_equal true, @validation.valid_coordinate?("B3")
  end

  def test_validation_can_test_placement_based_on_length
    assert_equal false, @validation.valid_length?(@cruiser, ["A1", "A2"])
    assert_equal false, @validation.valid_length?(@submarine, ["A2", "A3", "A4"])
    assert_equal true, @validation.valid_length?(@cruiser, ["A1", "A2", "A3"])
    assert_equal false, @validation.valid_length?(@cruiser, ["A1", "A2", "A3", "A4"])
  end

  def test_validation_can_split_into_coordinates
    assert_equal ["A", "1", "B", "1", "C", "1"], @validation.coordinate_split(["A1", "B1", "C1"])
    assert_equal ["A", "1", "A", "2", "A", "3", "A", "4"], @validation.coordinate_split(["A1", "A2", "A3", "A4"])
  end

  def test_validation_creates_row_coord_ords

   assert_equal [65, 65, 65], @validation.row_coord_ord(["A1", "A2", "A3"])
   assert_equal [66, 67, 68], @validation.row_coord_ord(["B2", "C2", "D2"])
  end

  def test_validation_can_handle_column_coord_ord
    assert_equal [50, 50, 50], @validation.column_coord_ord(["B2", "C2", "D2"])
    assert_equal [49, 49, 49], @validation.column_coord_ord(["A1", "B1", "C1"])
  end

  def test_validation_can_tell_if_row
   assert_equal true, @validation.row_ord?(["A1", "A2", "A3"])
   assert_equal false, @validation.row_ord?(["A1", "B1", "C1"])
  end

  def test_validation_can_tell_if_column
   assert_equal true, @validation.column_ord?(["A1", "B1", "C1"])
   assert_equal false, @validation.column_ord?(["A1", "A2", "A3"])
  end

  def test_validation_has_row_consecutive_array
    assert_equal [[49, 50], [50, 51]], @validation.row_consecutive_arr(["A1", "A2", "A3"])
    assert_equal [[49, 51], [51, 52]], @validation.row_consecutive_arr(["A1", "A3", "A4"])
    assert_equal [[49, 51], [51, 52]], @validation.row_consecutive_arr(["B1", "B3", "B4"])
  end

  def test_validation_has_row_consecutive_array
    assert_equal [[65, 66], [66, 67]], @validation.column_consecutive_arr(["A1", "B1", "C1"])
    assert_equal [[66, 67], [67, 68]], @validation.column_consecutive_arr(["B1", "C1", "D1"])
    assert_equal [[66, 67], [67, 68]], @validation.column_consecutive_arr(["B2", "C2", "D2"])
  end

  #We may need to test this can work in reverse as well
  def test_validation_can_place_ships_consecutively_rows
    assert_equal true, @validation.row_consecutive?(["A1", "A2", "A3", "A4"])
    assert_equal false, @validation.row_consecutive?(["A1", "A3", "A4"])
    assert_equal false, @validation.row_consecutive?(["A1", "A4"])
    assert_equal false, @validation.row_consecutive?(["A1", "A3"])
  end

  #We may need to test this can work in reverse as well
  def test_validation_can_place_ships_consecutively_columns
    assert_equal true, @validation.column_consecutive?(["A1", "B1", "D1"])
    assert_equal false, @validation.column_consecutive?(["A3", "C3", "D3"])
    assert_equal false, @validation.column_consecutive?(["B1", "D1"])
    assert_equal false, @validation.column_consecutive?(["B3", "D3"])
  end

  def test_validation_test_does_not_pass_diagonals
    assert_equal false, @validation.valid_diagonal?(["A1", "B2", "C3"])
    assert_equal false, @validation.valid_diagonal?(["B2", "C3", "D4"])
    assert_equal false, @validation.valid_diagonal?(["B1", "C2"])
    assert_equal false, @validation.valid_diagonal?(["B3", "D4"])
  end

  def test_ship_placement_validates_ships_overlapping
    @board.cells["A1"].place_ship(@cruiser)
    @board.cells["A2"].place_ship(@cruiser)
    @board.cells["A3"].place_ship(@cruiser)
    assert_equal true, @validation.ships_overlap(@cruiser, ["A1", "A2", "A3"])
  end
end
