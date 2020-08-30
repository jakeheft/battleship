require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'
require './lib/player'
require './lib/computer'
require './lib/turn'

class TurnTest < MiniTest::Test

  def test_it_exists
    player = Player.new("Timmy")
    computer = Computer.new
    player_board = Board.new
    computer_board = Board.new
    turn = Turn.new(player, computer, player_board, computer_board)

    assert_instance_of Turn, turn
  end

  def test_it_can_print_computer_board
    # game = Game.new
    player = Player.new("Timmy")
    computer = Computer.new
    player_board = Board.new
    computer_board = Board.new
    turn = Turn.new(player, computer, player_board, computer_board)

    expected = "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"
    assert_equal expected, turn.print_computer_board
  end

end
