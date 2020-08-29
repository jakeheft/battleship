require './lib/board'

class Player
  attr_reader :name, :ship_placement

  def initialize(name)
    @name = name
    @ship_placement = []
  end

# this is string/array info only, restrictions on array size will be controlled in the game
  def query_place_ship
    answer = gets.chomp
    @ship_placement = answer.split(" ")
    
  end

# this is string info only, restrictions on validity of string will be controlled in the game
  def query_fire_upon
    (answer = gets.chomp).upcase
  end

#run coordinates = gets.chomp in game start method, then coordinates are carried into player.place_ship method via argument
  # def place_ship(ship, coordinates_string) #pass in board as argument
  #   coordinates = coordinates_string.split(" ")
  #
  #   coordinates.each do |coordinate|
  #     require "pry"; binding.pry
  #     coordinates[coordinate].place_ship(ship)
  #   end
  # end
end
