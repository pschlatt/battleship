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

  def test_for_prompt_input
    assert_equal "Welcome to BATTLESHIP
    Enter p to play. Enter q to quit.",
    @current_game.prompt_user_input
    #assert_equal @current_game.player_ship_placement, @current_game.prompt_user_input
  end


end
