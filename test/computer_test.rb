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
    computer = Computer.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal 3, computer.query_place_ship(cruiser.length).length
    assert_equal 2, computer.query_place_ship(submarine.length).length
  end

  def test_computer_can_choose_fire_upon_coordinates
    computer = Computer.new

    assert_equal 16, computer.cells.length
    computer.query_fire_upon
    assert_equal 15, computer.cells.length
  end
end
