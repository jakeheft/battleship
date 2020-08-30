class Turn
  attr_reader :computer, :player, :player_board, :computer_board
  def initialize(player, computer, player_board, computer_board)
    @player = player
    @computer = computer
    @player_board = player_board
    @computer_board = computer_board
  end

  def print_computer_board
    puts "=============COMPUTER BOARD============="
    @computer_board.render
  end

  def print_player_board
    puts "==============PLAYER BOARD=============="
    @player_board.render
  end

  def computer_fires_upon_cell
    fire_location = @computer.query_fire_upon
    @player_board.cells[fire_location].fire_upon
  end

  def player_fires_upon_cell
    print "Enter the coorindate for your shot:\n>  "
    fire_location = @player.query_fire_upon
    player_choice = ""
    until @computer_board.validate_coordinate?(fire_location) && (@computer_board.cells[fire_location].fired_upon? == false) || (player_choice == 'yes' || player_choice == 'y')
      if @computer_board.cells[fire_location].render == "H" || @computer_board.cells[fire_location].render == "M" || @computer_board.cells[fire_location].render == "X"
        puts "You have already fired upon this cell; are you sure you want to proceed with this selection? y/n"
        player_choice = gets.chomp.downcase
      else
        puts "Please enter a valid coordinate:\n>  "
        fire_location = @player.query_fire_upon
      end
    end
    @computer_board.cells[fire_location].fire_upon
  end

end
