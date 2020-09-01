require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'
require './lib/player'
require './lib/computer'
require './lib/turn'

class TurnTest < MiniTest::Test

  def test_it_exists
    player = Player.new
    computer = Computer.new
    player_board = Board.new
    computer_board = Board.new
    turn = Turn.new(player, computer, player_board, computer_board)

    assert_instance_of Turn, turn
  end

  def test_it_can_print_computer_board
    player = Player.new
    computer = Computer.new
    player_board = Board.new
    computer_board = Board.new
    turn = Turn.new(player, computer, player_board, computer_board)

    expected = "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"
    assert_equal expected, turn.print_computer_board
  end

  def test_it_can_print_player_board
    player = Player.new
    computer = Computer.new
    player_board = Board.new
    computer_board = Board.new
    turn = Turn.new(player, computer, player_board, computer_board)

    expected = "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"
    assert_equal expected, turn.print_player_board
  end

  def test_computer_can_fire_upon_cell
    player = Player.new
    computer = Computer.new
    player_board = Board.new
    computer_board = Board.new
    turn = Turn.new(player, computer, player_board, computer_board)

    actual = player_board.cells.select.any? do |key, value|
      value.fired_status == true
    end
    assert_equal false, actual

    turn.computer_fires_upon_cell

    actual2 = player_board.cells.select.any? do |key, value|
      value.fired_status == true
    end
    assert actual2
  end

  def test_a_turn_will_end_if_all_ships_sunk
    player = Player.new
    computer = Computer.new
    player_board = Board.new
    computer_board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    turn = Turn.new(player, computer, player_board, computer_board)

    assert_equal false, turn.player_board.has_lost?

    player_board.place(cruiser, ["A1", "A2", "A3"])
    player_board.place(submarine, ["B1", "B2"])
    player_board.cells["A1"].fire_upon
    player_board.cells["A2"].fire_upon
    player_board.cells["A3"].fire_upon
    player_board.cells["B1"].fire_upon
    player_board.cells["B2"].fire_upon

    assert turn.player_board.has_lost?
    assert turn.game_over?(cruiser, submarine)
  end

end
