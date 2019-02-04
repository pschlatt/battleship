require './lib/board'
require './lib/cell'
require './lib/ship'
require 'pry'

cruiser = Ship.new("Cruiser", 3)
submarine = Ship.new("Submarine", 2)
patrolboat = Ship.new("Patrol Boat", 2)
new_board = Board.new
new_board.cells["A1"].place_ship(cruiser)
new_board.cells["A2"].place_ship(cruiser)
new_board.cells["A3"].place_ship(cruiser)
new_board.cells["C3"].place_ship(submarine)
new_board.cells["D3"].place_ship(submarine)
new_board.cells["B2"].place_ship(patrolboat)
new_board.cells["C2"].place_ship(patrolboat)
new_board.cells["C3"].fire_upon
new_board.cells["D3"].fire_upon
new_board.cells["A1"].fire_upon
new_board.cells["A2"].fire_upon
new_board.cells["A3"].fire_upon
new_board.cells["B2"].fire_upon
new_board.render
new_board.render(true)
