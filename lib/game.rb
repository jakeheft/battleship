class Game
  attr_reader :board, :player, :cruiser, :submarine

  def initialize
    @board = Board.new
    @player = Player.new("Timmy")
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  # This will be run via the runner and it will check whether "p" or "q" is input. If neither is input, it will give 3 chances before exiting the game. If "p" is input, it will run game.start
  def main_menu
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit."
    answer = gets.chomp.downcase
  end

#run coordinates = gets.chomp in game start method, then coordinates are carried into player.place_ship method via argument
  def place_ship
    coordinates = coordinates_string.split(" ")

    coordinates.each do |coordinate|
      @board.cells[coordinate].place_ship(ship)
      # require "pry"; binding.pry
    end
  end

  def start

  end


end
