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





end




#
# pry(main)> cell.ship
# # => nil
#
# pry(main)> cell.empty?
# # => true
#
# pry(main)> cruiser = Ship.new("Cruiser", 3)
# # => #<Ship:0x00007f84f0891238...>
#
# pry(main)> cell.place_ship(cruiser)
#
# pry(main)> cell.ship
# # => #<Ship:0x00007f84f0891238...>
#
# pry(main)> cell.empty?
# # => false
