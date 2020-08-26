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

    assert_equal 16, board.cells.count
    assert_instance_of Cell, board.cells["A1"]
  end

  def test_if_coordinate_is_on_board_or_not
    board = Board.new

    assert board.validate_coordinate?("A1")
    assert board.validate_coordinate?("D4")
    assert_equal false, board.validate_coordinate?("A5")
    assert_equal false, board.validate_coordinate?("E1")
    assert_equal false, board.validate_coordinate?("A22")
  end

  def test_if_multiple_coordinate_are_on_board_or_not
    board = Board.new

    assert board.validate_coordinates?(["A1", "A2", "A3"])
    assert board.validate_coordinates?(["B3", "C3", "D3"])
    assert_equal false, board.validate_coordinates?(["A4", "A5"])
    assert_equal false, board.validate_coordinates?(["D1", "E1"])
  end

  def test_number_of_coordinate_in_array_equals_length_of_ship
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2"])
    assert_equal false, board.valid_placement?(submarine, ["A2", "A3", "A4"])
    assert board.valid_placement?(cruiser, ["B1", "C1", "D1"])
  end

  def test_coordinates_are_consecutive
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert board.consecutive_coordinates?(["A1", "A2", "A3"])
    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2", "A4"])
    assert_equal false, board.valid_placement?(submarine, ["A1", "C1"])
    assert_equal false, board.valid_placement?(cruiser, ["A3", "A2", "A1"])
    assert board.valid_placement?(submarine, ["C1", "B1"])
  end

  def test_coordinates_cant_be_diagonal
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "B2", "C3"])
    assert_equal false, board.valid_placement?(submarine, ["C2", "D3"])
  end

  def test_placements_can_be_valid
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert board.valid_placement?(submarine, ["A1", "A2"])
    assert board.valid_placement?(cruiser, ["B1", "C1", "D1"])
    assert_equal false, board.valid_placement?(cruiser, ["A3", "A4", "A5"])
  end

  def test_a_ship_contains_multiple_cells
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    board.place(cruiser, ["A1", "A2", "A3"])

    cell_1 = board.cells["A1"]
    cell_2 = board.cells["A2"]
    cell_3 = board.cells["A3"]

    cell_1.ship
    cell_2.ship
    cell_3.ship
    assert cell_3.ship == cell_2.ship
    assert_equal cruiser, cell_1.ship
  end

  def test_ships_cant_overlap
    skip
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    board.place(cruiser, ["A1", "A2", "A3"])

    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(submarine, ["A1", "B1"])
  end

  def test_true_render_will_map_ships
    skip
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    expected1 = "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"
    expected2 = "  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n"

    board.place(cruiser, ["A1", "A2", "A3"])
    assert_equal expected1, board.render
    assert_equal expected2, board.render(true)
  end

end
