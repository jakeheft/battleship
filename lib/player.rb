class Player
  attr_reader :ship_placement

  def initialize
    @ship_placement = []
  end

  def query_place_ship
    answer = user_input
    @ship_placement = answer.split(" ")
  end

  def user_input
    gets.chomp.upcase
  end

  def query_fire_upon
    (answer = gets.chomp).upcase
  end
end
