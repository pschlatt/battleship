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
    @cpu_board = Board.new
    @player_board = Board.new
  end

  def test_instance_of_game
    assert_instance_of Game, @current_game
  end

  def test_computer_can_place_random_arrays
    assert_equal 3, @current_game.cpu_cruiser_generator.count
  end

  def test_cpu_cruiser_generator_works
    assert_equal 3, @current_game.cpu_cruiser_generator.count
  end

  def test_cpu_submarine_generator_works
    assert_equal 2, @current_game.cpu_submarine_generator.count
  end

  def test_player_game_end
    @cpu_board.place(@cpu_cruiser, ["A1", "A2", "A3"])
    @cpu_board.place(@cpu_submarine, ["b2", "b3"])
    @cpu_board.cells["A1"].fire_upon
    @cpu_board.cells["A2"].fire_upon
    @cpu_board.cells["A3"].fire_upon
    @cpu_board.cells["B2"].fire_upon
    @cpu_board.cells["B3"].fire_upon
    assert_equal true, @current_game.player_game_end?
  end

  def test_computer_game_end
    @player_board.place(@user_cruiser, ["A1", "A2", "A3"])
    @player_board.place(@user_submarine, ["b2", "b3"])
    @player_board.cells["A1"].fire_upon
    @player_board.cells["A2"].fire_upon
    @player_board.cells["A3"].fire_upon
    @player_board.cells["B2"].fire_upon
    @player_board.cells["B3"].fire_upon
    assert_equal true, @current_game.cpu_game_end?
  end
end
