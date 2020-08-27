class Game
  attr_reader :board, :player, :cruiser, :submarine

  def initialize
    @board = Board.new
    @player = Player.new("Timmy")
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  def main_menu

  end

#run coordinates = gets.chomp in game start method, then coordinates are carried into player.place_ship method via argument
  def place_ship(ship, coordinates_string)
    # player.query_place_ship
    # computer.query_place_ship
    # coordinates = coordinates_string.split(" ")

    coordinates.each do |coordinate|
      @board.cells[coordinate].place_ship(ship)
      # require "pry"; binding.pry
    end
  end

  def fire_upon(cell)
    # player.query_fire_upon
    # computer.query_fire_upon
    cell.fire_upon
  end

  def start

  end


end
