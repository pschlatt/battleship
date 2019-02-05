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
    @cpu_submarine = Ship.new("Submarine", 2)
  end

  def prompt_user_input
    system('clear')
     print "Welcome to BATTLESHIP \n"
     print "Enter p to play. Enter q to quit."
     process_input
  end

  def process_input
    system('clear')
    user_input = gets.chomp
    case user_input
    when "p"
      player_ship_placement
    when "q"
      exit!
    else
      print "#{"\n\n\n"}Invalid Input.#{"\n\n\n"}"
      prompt_user_input
    end
  end


  def player_ship_placement
    cpu_placement_cruiser
    cpu_placement_submarine
    system('clear')
    print "I have laid out my ships on the grid.\n"
    print "You now need to lay out your two ships.\n"
    print "The Submarine is two units long and the\n"
    print "Cruiser is three units long.\n"
    print "\n"
    sleep(4)
    @player_board.render
    player_input_coordinates_cruiser
  end

  def player_input_coordinates_cruiser
    system('clear')
    print "Enter the squares for the Cruiser with 3 spaces in between (ex. A1 A2 A3): "
    print "\n"
    cruiser_input = gets.chomp.upcase.split(" ")
    user_cruiser = Ship.new("Cruiser", 3)
    if @player_board.validation.valid_placement?(user_cruiser, cruiser_input)
      @player_board.place(user_cruiser, cruiser_input)
      @player_board.render(true)
    else
      print "Those are invalid coordinates. Please try again:"
      sleep(2)
      player_input_coordinates_cruiser
    end
    player_input_coordinates_submarine
    player_turn
  end

  def player_input_coordinates_submarine
    system('clear')
    print "Enter the squares for the Submarine with 2 spaces in between (ex. B1 B2): "
    print "\n"
    submarine_input = gets.chomp.upcase.split(" ")
    user_submarine = Ship.new("Submarine", 2)

    if @player_board.validation.valid_placement?(user_submarine, submarine_input)
      @player_board.place(user_submarine, submarine_input)
      @player_board.render(true)
    else
      system('clear')
      p "Those are invalid coordinates. Please try again:"
      sleep(2)
      player_input_coordinates_submarine
    end
  end

  def cpu_ship_placement
    cpu_placement_cruiser
    cpu_placement_submarine
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

  def cpu_cruiser_placement_validation
    new_values = cpu_cruiser_generator
    until @cpu_board.validation.valid_placement?(@cpu_cruiser, new_values)
      new_values = cpu_cruiser_generator
    end
    return new_values.sort
  end

  def cpu_placement_cruiser
    @cpu_board.place(@cpu_cruiser, cpu_cruiser_placement_validation)
  end

  def cpu_submarine_generator
    random_values = []
    random_values << @cpu_board.render_master.values.flatten.sample
    random_values.each do |value|
      if random_values.count < @cpu_submarine.length
        random_values << @cpu_board.render_master.values.flatten.sample
      end
    end
    return random_values
  end

  def cpu_submarine_placement_validation
    new_values = cpu_submarine_generator
    until @cpu_board.validation.valid_placement?(@cpu_submarine, new_values)
      new_values = cpu_submarine_generator
    end
    return new_values.sort
  end

  def cpu_placement_submarine
    @cpu_board.place(@cpu_submarine, cpu_submarine_placement_validation)
  end

  def computer_turn
    system('clear')
    print "The computer is firing"
    sleep(2)
    system('clear')
  end

  def player_turn
    system('clear')
    print "=============COMPUTER BOARD============="
    print "\n"
    @cpu_board.render(true)
    print "==============PLAYER BOARD=============="
    print "\n"
    @player_board.render(true)
    print "Enter the coordinate for your shot: "
    player_shot = gets.chomp
    @cpu_board.cells[player_shot].fire_upon
    if @cpu_board.cells[player_shot].empty? == true
      print "You missed."
      print "\n"
      sleep(2)
    else
      print "It's a hit!"
      print "\n"
      sleep(2)
    end
  end
end
