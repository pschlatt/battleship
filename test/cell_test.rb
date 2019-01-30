require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require 'pry'
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

  def test_ship_has_not_been_fired_upon
    cruiser = Ship.new("Cruiser", 3)
    @cell.place_ship(cruiser)
    assert_equal false, @cell.fired_upon?
  end

  def test_ship_has_been_hit
    cruiser = Ship.new("Cruiser", 3)
    @cell.place_ship(cruiser)
    @cell.fire_upon
    assert_equal 2, cruiser.health
  end

  def test_ship_has_been_fired_upon
    cruiser = Ship.new("Cruiser", 3)
    @cell.place_ship(cruiser)
    @cell.fire_upon
    assert_equal true, @cell.fired_upon?
  end

  def test_cell_can_render

    assert_equal ".", @cell.render
  end

  def test_cell_renders_a_miss
    @cell.fire_upon
    assert_equal "M", @cell.render
  end

  def test_cell_renders_a_hit
    cruiser = Ship.new("Cruiser", 3)
    @cell.place_ship(cruiser)
    @cell.fire_upon
    assert_equal "H", @cell.render
  end

  def test_it_can_render_both_cells
    cruiser = Ship.new("Cruiser", 3)
    @cell_2 = Cell.new("C3")
    @cell.place_ship(cruiser)
    @cell_2.place_ship(cruiser)
    assert_equal ".", @cell_2.render
  end

  def test_ship_has_default_argument
    cruiser = Ship.new("Cruiser", 3)
    @cell_2 = Cell.new("C3")
    @cell.place_ship(cruiser)
    @cell_2.place_ship(cruiser)
    assert_equal "S", @cell_2.render(true)
  end
end

# pry(main)> cell_2.fire_upon
#
# pry(main)> cell_2.render
# # => "H"
#
# pry(main)> cruiser.sunk?
# # => false
#
# pry(main)> cruiser.hit
#
# pry(main)> cruiser.hit
#
# pry(main)> cruiser.sunk?
# # => true
#
# pry(main)> cell_2.render
# # => "X"
