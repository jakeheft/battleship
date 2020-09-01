require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/player'

class PlayerTest < Minitest::Test
  def test_it_exists
    player = Player.new

    assert_instance_of Player, player
  end

  def test_player_can_be_asked_for_ship_placement
    player = Player.new

    player.query_place_ship
    # We entered "a1" when queried
    assert_equal false, player.ship_placement.empty?
  end

  def test_player_can_fire_at_cell
    player = Player.new
    board = Board.new

    # We entered "a1" when queried
    assert_equal "A1", player.query_fire_upon
  end

end
