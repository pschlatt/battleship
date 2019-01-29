require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'


class ShipTest < Minitest::Test

  def setup
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_it_has_a_name
    assert_equal "Cruiser", @cruiser.name
  end

  def test_it_has_a_length
    assert_equal 3, @cruiser.length
  end

  def test_it_has_health
    assert_equal 3, @cruiser.health
  end

  def test_it_has_sunk_method
    assert_equal false, @cruiser.sunk?
  end

  def test_ship_can_get_hit
    @cruiser.hit
    assert_equal 2, @cruiser.health
  end

  def test_ship_can_get_hit_again
    @cruiser.hit
    @cruiser.hit
    @cruiser.hit


    refute_equal 3, @cruiser.health
    refute_equal 2, @cruiser.health
    refute_equal 1, @cruiser.health
    assert_equal 0, @cruiser.health
    assert_equal true, @cruiser.sunk?
  end
end
