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

  def test_player_can_be_asked_for_ship_placement
    skip
    player = Player.new("Timmy")

    refute_nil player.query_place_ship
    assert_equal false, player.ship_placement.empty?
  end

  def test_player_can_fire_at_cell
    player = Player.new("Timmy")
    board = Board.new

    assert_equal "A1", player.query_fire_upon # We entered "a1" when queried"
  end

end
