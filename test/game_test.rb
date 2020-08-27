require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'
require './lib/player'

class GameTest < MiniTest::Test

  def test_it_exists
    game = Game.new

    assert_instance_of Game, game
  end

  def test_player_can_place_ships
    game = Game.new
    # cruiser = Ship.new("Cruiser", 3)
    # board = Board.new

    game.place_ship(game.cruiser, "A1 A2 A3")

    assert_equal false, game.board.coordinates_empty?(["A1", "A2", "A3"])
    assert_equal game.cruiser, game.board.cells["A1"].ship
  end

    def test_player_can_fire_on_cell
      player = Player.new("Timmy")
      cruiser = Ship.new("Cruiser", 3)
      board = Board.new

      player.fire_upon("A1")
      assert_equal "M", board.cells["A1"].render
    end
end
