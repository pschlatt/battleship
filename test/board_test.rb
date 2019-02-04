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

  # def test_board_can_render
  #   @board.place(@cruiser, ["A1", "A2", "A3"])
  #   render = "  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n"
  #   assert_equal render, @board.render
  # end
  #
  # def test_board_can_render_hidden_cells
  #   render = "  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n"
  #   assert_equal render, @board.render
  # end
end
