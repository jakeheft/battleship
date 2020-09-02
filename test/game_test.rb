require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/turn'
require './lib/game'
require './lib/player'
require './lib/computer'

class GameTest < MiniTest::Test

  def test_it_exists
    game = Game.new

    assert_instance_of Game, game
  end

  def test_a_game_ends_when_player_ships_sunk
    game = Game.new

    game.player_board.place(game.player_cruiser, ["A1", "A2", "A3"])
    game.player_board.place(game.player_submarine, ["B1", "B2"])
    game.player_board.cells["A1"].fire_upon
    game.player_board.cells["A2"].fire_upon
    game.player_board.cells["A3"].fire_upon
    game.player_board.cells["B1"].fire_upon
    game.player_board.cells["B2"].fire_upon

    assert game.end_game
  end

  def test_a_game_runs_through_main_menu
    game = Game.new

    game.main_menu
  end
end
