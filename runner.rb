require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/game'
#require './lib/helper'

@game = Game.new
@game.prompt_user_input
