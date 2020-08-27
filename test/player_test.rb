require "minitest/autorun"
require "minitest/pride"
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/player'

class PlayerTest < Minitest::Test
  def test_it_exists
    player = Player.new("Timmy")

    assert_instance_of Player, player
  end

  def test_it_has_attributes
    player = Player.new("Timmy")

    assert_equal "Timmy", player.name
  end

  def test_player_can_place_ships
    player = Player.new("Timmy")
    cruiser = Ship.new("Cruiser", 3)
    board = Board.new
    

    player.place_ship(cruiser, "A1 A2 A3")

    assert_equal false, board.coordinates_empty?(["A1", "A2", "A3"])

  end

end
