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

  def test_computer_can_create_ship_coordinates
    board = Board.new
    computer = Computer.new
    cruiser = Ship.new("Cruiser", 3)

    assert_equal 3, computer.query_place_ship(3).length
    assert_equal 2, computer.query_place_ship(2).length
  end
end
