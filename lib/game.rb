require './lib/board'
require './lib/cell'
require './lib/ship'
require "pry"


class Game

  def initialize
    @game = true
    @player_board = Board.new
    @cpu_board = Board.new
    @cpu_cruiser = Ship.new("Cruiser", 3)
    @cpu_submarine = Ship.new("Cruiser", 2)
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
    @player_board.render
    cpu_placement_cruiser
    player_input_coordinates_cruiser
  end

  def player_input_coordinates_cruiser
    puts "Enter the squares for the Cruiser (3 spaces):
> "
    cruiser_input = gets.chomp.upcase.split(" ")
    user_cruiser = Ship.new("Cruiser", 3)
    if @player_board.validation.valid_placement?(user_cruiser, cruiser_input)
      @player_board.place(user_cruiser, cruiser_input)
      @player_board.render(true)
    else
      p "Those are invalid coordinates. Please try again:"
      player_input_coordinates_cruiser
    end
    player_input_coordinates_submarine
    player_turn
  end

  def player_input_coordinates_submarine
    puts "Enter the squares for the Submarine (2 spaces):
    > "
    submarine_input = gets.chomp.upcase.split(" ")
    user_submarine = Ship.new("Submarine", 2)

    if @player_board.validation.valid_placement?(user_submarine, submarine_input)
      @player_board.place(user_submarine, submarine_input)
      @player_board.render(true)
    else
      p "Those are invalid coordinates. Please try again:"
      player_input_coordinates_submarine
    end
  end

  def player_turn
    p "=============COMPUTER BOARD============="
    @player_board.render
    p "==============PLAYER BOARD=============="
    @player_board.render(true)
    p "Enter the coordinate for your shot: "
  end

  def cpu_cruiser_generator
    random_values = []
    random_values << @cpu_board.render_master.values.flatten.sample
    random_values.each do |value|
      if random_values.count < @cpu_cruiser.length
        random_values << @cpu_board.render_master.values.flatten.sample
      end
    end
    return random_values
  end

  def cpu_placement_cruiser
    cpu_cruiser_generator
    new_values = cpu_cruiser_generator
    if @cpu_board.validation.valid_placement?(@cpu_cruiser, new_values) == false
      cpu_placement_cruiser
    else
      return new_values
    end
  end


  def computer_turn
  end

end
