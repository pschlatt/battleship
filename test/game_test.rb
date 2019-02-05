require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/game'

class GameTest < Minitest::Test

  def setup
    @current_game = Game.new
  end

  def test_instance_of_game
    assert_instance_of Game, @current_game
  end

  # def test_for_prompt_input
  #   assert_equal "Welcome to BATTLESHIP
  #   Enter p to play. Enter q to quit.",
  #   @current_game.prompt_user_input
  #   #assert_equal @current_game.player_ship_placement, @current_game.prompt_user_input
  # end

  def test_computer_can_place_random_arrays
    assert_equal 3, @current_game.cpu_cruiser_generator.count
  end

  def test_computer_can_place_cruiser
    assert_instance_of Ship, @current_game.cpu_placement_cruiser
  end
end
