require "minitest/autorun"
require "minitest/pride"
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/computer'

class ComputerTest < Minitest::Test
  def test_it_exists
    computer = Computer.new

    assert_instance_of Computer, computer
  end

  def test_computer_gives_ship_placement
    board = Board.new
    computer = Computer.new(board)
    cruiser = Ship.new("Cruiser", 3)

    refute_nil computer.query_place_ship(cruiser.length)
    assert_equal false, computer.ship_placement.empty?
  end

end
