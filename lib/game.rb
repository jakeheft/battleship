class Game
  attr_reader :board, :player, :cruiser, :submarine, :computer

  def initialize
    @computer_board = Board.new
    @player_board = Board.new
    @player = Player.new("Timmy")
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @computer = Computer.new
  end

  # This will be run via the runner and it will check whether "p" or "q" is input. If neither is input, it will give 3 chances before exiting the game. If "p" is input, it will run game.start
  def main_menu
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit."
    answer = gets.chomp.downcase
  end

#run coordinates = gets.chomp in game start method, then coordinates are carried into player.place_ship method via argument
  def computer_place_ships
    computer_cruiser = computer.query_place_ship(cruiser.length)
    computer_submarine = computer.query_place_ship(submarine.length)
    @computer_board.place(cruiser, computer_cruiser)
    @computer_board.place(submarine, computer_submarine)
  end

  def player_place_ships
    player_cruiser = player.query_place_ship
    until player_cruiser.length == 3 && @player_board.valid_placement?(cruiser, player_cruiser)
      puts "Please select valid coordinates. Enter 3 coordinates separated by a space."
    end
    @player_board.place(cruiser, player_cruiser)
    player_submarine = player.query_place_ship
    until player_cruiser.length == 2 && @player_board.valid_placement?(cruiser, player_cruiser)
      puts "Please select valid coordinates. Enter 2 coordinates separated by a space that are empty."
    end
    @player_board.place(submarine, player_submarine)
  end

  def start

  end


end
