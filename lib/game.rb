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
    player_turn
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
    print "\n"
    computer_fire
    # sleep(2)
    system('clear')
  end

  def player_turn
    system('clear')
    print "=============COMPUTER BOARD============="
    print "\n"
    print @cpu_board.render
    print "==============PLAYER BOARD=============="
    print "\n"
    print @player_board.render(true)
    print "Enter the coordinate for your shot: "
    player_shot = gets.chomp.upcase
    until @player_board.valid_coordinate?(player_shot)
      player_shot = gets.chomp.upcase
    end
    if @cpu_board.cells[player_shot].fired_upon? == true
      print "\n"
      print "You've already shot there.  Try again."
      sleep(2)
      player_turn
    end
    @cpu_board.cells[player_shot].fire_upon
    if @cpu_board.cells[player_shot].empty? == true
      print "Your shot missed on #{player_shot}."
      print "\n"
      sleep(2)
      computer_turn
    elsif @cpu_board.cells[player_shot].ship.sunk? == true
      print "You sunk their ship!"
      print "\n"
      sleep(2)
      game_results
      computer_turn
    else
      print "Your shot on #{player_shot} was a hit!"
      print "\n"
      sleep(2)
      computer_turn
    end
  end

  def computer_fire
    cpu_shooting = @player_board.render_master.values.flatten.sample
    @player_board.cells.each_value do |value|
      if @player_board.cells[cpu_shooting].fired_upon? == false
        @player_board.cells[cpu_shooting].fire_upon
        if @player_board.cells[cpu_shooting].ship == nil
          print "\n"
          print "Computer missed shot on #{cpu_shooting}!"
          sleep(2)
          player_turn
        elsif @player_board.cells[cpu_shooting].ship.sunk? == true
          print "\n"
          print "Computer hit your ship on coordinate #{cpu_shooting}!"
          sleep(2)
          game_results
          player_turn
        else
          print "The computer hit your ship on #{cpu_shooting}!"
          sleep(2)
          player_turn
        end
      else @player_board.cells[cpu_shooting].fired_upon? == true
        computer_fire
      end
    end
  end

  def game_results
    if cpu_game_end? == true
      system('clear')
      print "The computer has won.  You'll need to walk this one off."
      sleep(5)
      prompt_user_input
    elsif player_game_end? == true
      system('clear')
      print "You've won!"
      sleep(5)
      prompt_user_input
    end
  end

  def cpu_game_end?
    ship_count = @player_board.cells.each_value.count do |value|
      value.ship != nil
    end
    ship_sunk = @player_board.cells.each_value.count do |value|
      if value.ship != nil
        value.ship.sunk?
      end
    end
    ship_count == ship_sunk
  end

  def player_game_end?
    ship_count = @cpu_board.cells.each_value.count do |value|
      value.ship != nil
    end
    ship_sunk = @cpu_board.cells.each_value.count do |value|
      if value.ship != nil
        value.ship.sunk?
      end
    end
    ship_count == ship_sunk
  end
end
