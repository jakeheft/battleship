require './lib/board'

class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end

#run coordinates = gets.chomp in game start method, then coordinates are carried into player.place_ship method via argument
  def place_ship(ship, coordinates_string) #pass in board as argument
    coordinates = coordinates_string.split(" ")

    coordinates.each do |coordinate|
      require "pry"; binding.pry
      coordinates[coordinate].place_ship(ship)
    end
  end
end
