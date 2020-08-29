require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'
require './lib/player'
require './lib/computer'

class GameTest < MiniTest::Test

  def test_it_exists
    game = Game.new

    assert_instance_of Game, game
  end

  def test_main_menu_asks_player_to_play
    game = Game.new

    assert ["p", "q"].include?(game.main_menu) # This will accept p or q as an answer
  end

  def test_computer_places_two_ships
    game = Game.new

    assert_equal 16, game.computer.placement_cells.length
    game.computer_place_ships
    assert_equal 11, game.computer.placement_cells.length
  end

  def test_player_can_place_ships
    game = Game.new

    assert_equal 0, game.player.ship_placement.length
    game.player_place_ships
    assert_equal 2, game.player.ship_placement.length
  end
end
