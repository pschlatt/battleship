require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/game'
require 'pry'

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
    cruiser = @current_game.cpu_ship_placement
    assert_equal cruiser, @current_game.cpu_placement_cruiser
  end

  def test_computer_can_place_submarine
    submarine = @current_game.cpu_ship_placement
    assert_equal submarine, @current_game.cpu_placement_submarine
  end

  def test_computer_can_fire
    assert_equal [], @current_game.computer_fire
  end
end
