class Player
  attr_reader :ship_placement

  def initialize
    @ship_placement = []
  end

  def query_place_ship
    answer = gets.chomp.upcase
    @ship_placement = answer.split(" ")
  end

  def query_fire_upon
    (answer = gets.chomp).upcase
  end

end
