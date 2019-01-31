require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/cell'
require './lib/ship'
require 'pry'

class BoardTest < Minitest::Test

  def setup
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  def test_board_exists
    assert_instance_of Board, @board

  end

  def test_board_has_cells
    assert_equal ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"], @board.cells.keys
  end

  def test_board_has_valid_coordinates
    assert_equal true, @board.valid_coordinate?("A2")
    assert_equal true, @board.valid_coordinate?("A1")
    assert_equal false, @board.valid_coordinate?("A5")
    assert_equal false, @board.valid_coordinate?("E1")
    assert_equal false, @board.valid_coordinate?("A22")
    assert_equal true, @board.valid_coordinate?("B3")
  end

  def test_board_can_test_placement_based_on_length
    assert_equal false, @board.valid_length?(@cruiser, ["A1", "A2"])
    assert_equal false, @board.valid_length?(@submarine, ["A2", "A3", "A4"])
    assert_equal true, @board.valid_length?(@cruiser, ["A1", "A2", "A3"])
    assert_equal false, @board.valid_length?(@cruiser, ["A1", "A2", "A3", "A4"])
  end

  def test_board_can_split_into_coordinates
    assert_equal ["A", "1", "B", "1", "C", "1"], @board.coordinate_split(["A1", "B1", "C1"])
    assert_equal ["A", "1", "A", "2", "A", "3", "A", "4"], @board.coordinate_split(["A1", "A2", "A3", "A4"])
  end

  def test_board_creates_row_coord_ords

   assert_equal [65, 65, 65], @board.row_coord_ord(["A1", "A2", "A3"])
   assert_equal [65, 66, 67], @board.row_coord_ord(["A1", "B1", "C1"])
  end

  def test_board_can_tell_if_row
   assert_equal true, @board.row_ord?(["A1", "A2", "A3"])
   assert_equal false, @board.row_ord?(["A1", "B1", "C1"])
  end

  def test_board_can_handle_column_coords
    skip
    assert_equal false, @board.column_coord?(@cruiser, ["A1", "A2", "A3"])
    assert_equal true, @board.column_coord?(@cruiser, ["A1", "B1", "C1"])
  end

  # def test_board_can_place_ships_consecutively
    # assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2", "A4"])
    # assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A3", "A4"])
    # assert_equal false, @board.valid_placement?(@submarine, ["A1", "A4"])
    # assert_equal false, @board.valid_placement?(@submarine, ["A1", "A3"])
  # end
end
