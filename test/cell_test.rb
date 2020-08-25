require "minitest/autorun"
require "minitest/pride"
require "./lib/cell"

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
end
