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
end




#
# pry(main)> cell_1 = Cell.new("B4")
# # => #<Cell:0x00007f84f11df920...>
#
# pry(main)> cell_1.render
# # => "."
#
# pry(main)> cell_1.fire_upon
#
# pry(main)> cell_1.render
# # => "M"
#
# pry(main)> cell_2 = Cell.new("C3")
# # => #<Cell:0x00007f84f0b29d10...>
#
# pry(main)> cruiser = Ship.new("Cruiser", 3)
# # => #<Ship:0x00007f84f0ad4fb8...>
#
# pry(main)> cell_2.place_ship(cruiser)
#
# pry(main)> cell_2.render
# # => "."
#
# # Indicate that we want to show a ship with the optional argument
# pry(main)> cell_2.render(true)
# # => "S"
#
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
