require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'

class CellTest < Minitest::Test

  def setup
    @cell = Cell.new("B4")
  end

  def test_cell_has_coordinate
    assert_equal "B4", @cell.coordinate
  end

  def test_cell_can_have_ship
    assert_equal nil, @cell.ship
  end

  def test_cell_is_empty
    assert_equal true, @cell.empty?
  end

  def test_cell_has_ship
    cruiser = Ship.new("Cruiser", 3)
    @cell.place_ship(cruiser)
    assert_equal cruiser, @cell.ship
  end

  def test_cell_is_not_empty
    cruiser = Ship.new("Cruiser", 3)
    @cell.place_ship(cruiser)
    assert_equal false, @cell.empty?
  end


end
