require "minitest/autorun"
require "minitest/pride"
require "./lib/cell"
require "./lib/ship"

class CellTest < Minitest::Test
  def test_it_exists
    cell = Cell.new("B4")

    assert_instance_of Cell, cell
  end

  def test_it_has_coordinates
    cell = Cell.new("B4")

    assert_equal "B4", cell.coordinate
  end

  def test_it_is_empty_to_start
    cell = Cell.new("B4")

    assert_nil cell.ship
    assert cell.empty?
  end

  def test_can_place_a_ship_on_cell
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    assert_instance_of Ship, cruiser
    cell.place_ship(cruiser)
    assert_equal cruiser, cell.ship
    cell.empty?
  end
end
