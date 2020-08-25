require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'

class BoardTest < MiniTest::Test

  def test_it_exists
    board = Board.new

    assert_instance_of Board, board
  end

  def test_board_creation_initializes_16_cells
    board = Board.new
    board.cells

    # test a hash with 16 key/value pairs is created
    # test those keys point to cell objects
  end

  def test_if_coordinate_is_on_board_or_not
    board = Board.new

    # ex: board.valid_coordinate?("A1") => true
    # ex: board.valid_coordinate?("A5") => false
  end

  def test_if_placement_of_ship_is_valid_or_not
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    # method valid_placement? takes two arguments: a Ship object and an array of Coordinates.
  end

  def test_number_of_coordinate_in_array_equals_length_of_ship
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    refute board.valid_placement?(cruiser, ["A1", "A2"])
    refute board.valid_placement?(submarine, ["A2", "A3", "A4"])
  end

  def test_coordinates_are_consecutive
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    refute board.valid_placement?(cruiser, ["A1", "A2", "A4"])
    refute board.valid_placement?(submarine, ["A1", "C1"])
    refute board.valid_placement?(cruiser, ["A3", "A2", "A1"])
    refute board.valid_placement?(submarine, ["C1", "B1"])
  end

  def test_coordinates_cant_be_diagonal
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    refute board.valid_placement?(cruiser, ["A1", "B2", "C3"])
    refute board.valid_placement?(submarine, ["C2", "D3"])
  end

end
