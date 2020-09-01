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

  def test_coordinates_are_consecutive
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert board.consecutive_coordinates?(["A1", "A2", "A3"])
    assert_equal false, board.consecutive_coordinates?(["A1", "A2", "A4"])
  end

  def test_can_check_if_coordinates_are_empty
    board = Board.new
    cell_1 = board.cells["A1"]
    cell_2 = board.cells["B1"]
    cell_3 = board.cells["C1"]

    assert board.coordinates_empty?(["A1", "B1", "C1"])
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

  def test_can_place_ships
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    cell_1 = board.cells["A1"]
    cell_2 = board.cells["A2"]
    cell_3 = board.cells["A3"]

    assert_nil cell_1.ship

    board.place(cruiser, ["A1", "A2", "A3"])

    assert_equal cruiser, cell_1.ship
  end

  def test_a_ship_contains_multiple_cells
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    cell_1 = board.cells["A1"]
    cell_2 = board.cells["A2"]
    cell_3 = board.cells["A3"]

    board.place(cruiser, ["A1", "A2", "A3"])

    assert cell_3.ship == cell_2.ship
    assert_equal cruiser, cell_1.ship
  end

  def test_ships_cant_overlap
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    board.place(cruiser, ["A1", "A2", "A3"])

    assert_equal false, board.valid_placement?(submarine, ["A1", "B1"])
  end

  def test_boards_can_render
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    expected1 = "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"
    expected2 = "  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n"

    board.place(cruiser, ["A1", "A2", "A3"])

    assert_equal expected1, board.render
    assert_equal expected2, board.render(true)
  end

  def test_has_lost_renders_as_X
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    cell_1 = board.cells["A1"]
    cell_2 = board.cells["A2"]
    cell_3 = board.cells["A3"]
    cell_4 = board.cells["B3"]
    cell_5 = board.cells["B4"]

    board.place(cruiser, ["A1", "A2", "A3"])
    board.place(submarine, ["B3", "B4"])
    cell_1.fire_upon
    cell_2.fire_upon
    cell_3.fire_upon
    cell_4.fire_upon
    cell_5.fire_upon

    assert board.has_lost?
  end

end
