require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/cell'
require 'pry'

class BoardTest < Minitest::Test

  def setup
    @board = Board.new
  end

  def test_board_exists
    assert_instance_of Board, @board

  end

  def test_board_has_cells
    assert_equal ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"], @board.cells.keys
  end

  def test_board_has_valid_coordinate
    assert_equal true, @board.valid_coordinate?("A1")
    assert_equal true, @board.valid_coordinate?("D4")
    assert_equal false, @board.valid_coordinate?("A5")
    assert_equal false, @board.valid_coordinate("E1")
    assert_equal false, @board.valid_coordinate("A22")
  end
end
