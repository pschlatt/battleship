require './lib/board'
require './lib/cell'
require './lib/ship'


class Game

  def initialize
    @game = true
    @board = Board.new
  end

  def prompt_user_input
     puts "Welcome to BATTLESHIP
     Enter p to play. Enter q to quit."
     process_input
  end

  def process_input
    user_input = gets.chomp
    case user_input
    when "p"
      player_ship_placement
    when "q"
      exit!
    else
      puts "#{"\n\n\n"}Invalid Input.#{"\n\n\n"}"
      prompt_user_input
    end

  end

  def player_ship_placement
    puts "I have laid out my ships on the grid.
You now need to lay out your two ships.
The Submarine is two units long and the
Cruiser is three units long."
    @board.render
    player_input_coordinates
  end

  def player_input_coordinates_cruiser
    puts "Enter the squares for the Cruiser (3 spaces):
> "
    cruiser_input = gets.chomp.upcase.split(" ")
    user_cruiser = Ship.new("Cruiser", 3)
    if @board.validation.valid_placement?(user_cruiser, cruiser_input)
      @board.place(user_cruiser, cruiser_input)
      @board.render(true)
    else
      p "Invalid placement. Try again."
      player_input_coordinates
    end
    player_input_coordinates_submarine
  end

  def player_input_coordinates_submarine
    puts "Enter the squares for the Submarine (2 spaces):
    > "
    cruiser_input = gets.chomp.upcase.split(" ")
    user_cruiser = Ship.new("Cruiser", 3)
    if @board.validation.valid_placement?(user_cruiser, cruiser_input)
      @board.place(user_cruiser, cruiser_input)
      @board.render(true)
    else
      p "Invalid placement. Try again."
      player_input_coordinates
    end
  end
end
