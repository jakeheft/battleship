class Turn
  attr_reader :computer, :player, :player_board, :computer_board, :computer_fire_location, :player_fire_location, :player_choice
  def initialize(player, computer, player_board, computer_board)
    @player = player
    @computer = computer
    @player_board = player_board
    @computer_board = computer_board
    @computer_fire_location = nil
    @player_fire_location = nil
    @player_choice = ""
  end

  def print_computer_board
    puts "\n=============COMPUTER BOARD============="
    @computer_board.render
  end

  def print_player_board
    puts "\n==============PLAYER BOARD=============="
    @player_board.render(true)
  end

  def computer_fires_upon_cell
    @computer_fire_location = @computer.query_fire_upon
    @player_board.cells[@computer_fire_location].fire_upon
  end

  def computer_cell_status
    @computer_board.cells[@player_fire_location].render
  end

  def cell_has_been_hit?
    computer_cell_status == "H" || computer_cell_status == "M" || computer_cell_status == "X"
  end

  def ask_for_valid_coordinate
    print "Please enter a valid coordinate:\n>  "
    @player_fire_location = @player.query_fire_upon
  end

  def player_fires_upon_cell
    print "\nEnter the coorindate for your shot:\n>  "
    @player_fire_location = @player.query_fire_upon
    until @computer_board.validate_coordinate?(@player_fire_location) && !@computer_board.cells[@player_fire_location].fired_upon? || (@player_choice == "yes" || @player_choice == "y")
      if !@computer_board.validate_coordinate?(@player_fire_location)
        ask_for_valid_coordinate
      elsif cell_has_been_hit?
        puts "You have already fired upon this cell; are you sure you want to proceed with this selection? y/n"
        @player_choice = gets.chomp.downcase
        if @player_choice == "n" || @player_choice == "no"
          ask_for_valid_coordinate
        end
      else
        ask_for_valid_coordinate
      end
    end
    if @player_choice == 'yes' || @player_choice == 'y'
    else
      @computer_board.cells[@player_fire_location].fire_upon
    end
  end

  def game_over?(cruiser, submarine)
    cruiser.sunk? && submarine.sunk?
  end

  def result_of_player_shot
    if @player_choice == "y" || @player_choice == "yes"
      "\nYou already shot on #{@player_fire_location}. Smooth move."
  elsif computer_cell_status == "H"
      "\nYour shot on #{@player_fire_location} was a hit."
  elsif computer_cell_status == "M"
      "\nYour shot on #{@player_fire_location} was a miss."
  elsif computer_cell_status == "X"
      "\nYour shot on #{@player_fire_location} was a hit and you sunk a ship."
    end
  end

  def player_cell_status
    @player_board.cells[@computer_fire_location].render
  end

  def result_of_computer_shot
    if player_cell_status == "H"
      "My shot on #{@computer_fire_location} was a hit."
    elsif player_cell_status == "M"
      "My shot on #{@computer_fire_location} was a miss."
    elsif player_cell_status == "X"
      "My shot on #{@computer_fire_location} was a hit and I sunk a ship."
    end
  end

  def run_turn(computer_cruiser, computer_submarine)
    puts print_computer_board
    puts print_player_board
    player_fires_upon_cell
    if !game_over?(computer_cruiser, computer_submarine)
      computer_fires_upon_cell
      puts result_of_player_shot
      puts result_of_computer_shot
    else
      puts result_of_player_shot
    end
  end

end
