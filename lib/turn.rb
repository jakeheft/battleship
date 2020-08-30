class Turn
  attr_reader :computer, :player, :player_board, :computer_board, :turn_count, :computer_fire_location, :player_fire_location
  def initialize(player, computer, player_board, computer_board)
    @player = player
    @computer = computer
    @player_board = player_board
    @computer_board = computer_board
    @turn_count = 0
    @computer_fire_location = nil
    @player_fire_location = nil
  end

  def print_computer_board
    puts "=============COMPUTER BOARD============="
    puts @computer_board.render
  end

  def print_player_board
    puts "==============PLAYER BOARD=============="
    puts @player_board.render(true)
  end

  def computer_fires_upon_cell
    @computer_fire_location = @computer.query_fire_upon
    @player_board.cells[@computer_fire_location].fire_upon
  end

  def player_fires_upon_cell
    print "Enter the coorindate for your shot:\n>  "
    @player_fire_location = @player.query_fire_upon
    player_choice = ""
    until @computer_board.validate_coordinate?(@player_fire_location) && (@computer_board.cells[@player_fire_location].fired_upon? == false) || (player_choice == 'yes' || player_choice == 'y')
      if @computer_board.cells[@player_fire_location].render == "H" || @computer_board.cells[@player_fire_location].render == "M" || @computer_board.cells[@player_fire_location].render == "X"
        puts "You have already fired upon this cell; are you sure you want to proceed with this selection? y/n"
        player_choice = gets.chomp.downcase
      else
        puts "Please enter a valid coordinate:\n>  "
        @player_fire_location = @player.query_fire_upon
      end
    end
    @computer_board.cells[@player_fire_location].fire_upon
  end

  def game_over?(cruiser, submarine)
    cruiser.sunk? && submarine.sunk?
  end

  def result_of_player_shot
    if @computer_board.cells[@player_fire_location].render == "H"
      "Your shot on #{@player_fire_location} was a hit."
    elsif @computer_board.cells[@player_fire_location].render == "M"
      "Your shot on #{@player_fire_location} was a miss."
    elsif @computer_board.cells[@player_fire_location].render == "X"
      "Your shot on #{@player_fire_location} was a hit and you sunk a ship."
    end
  end

  def result_of_computer_shot
    if @player_board.cells[@computer_fire_location].render == "H"
      "My shot on #{@computer_fire_location} was a hit."
    elsif @player_board.cells[@computer_fire_location].render == "M"
      "My shot on #{@computer_fire_location} was a miss."
    elsif @player_board.cells[@computer_fire_location].render == "X"
      "My shot on #{@computer_fire_location} was a hit and I sunk a ship."
    end
  end

  def run_turn(computer_cruiser, computer_submarine)
    @turn_count += 1
    print_computer_board
    print_player_board
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
