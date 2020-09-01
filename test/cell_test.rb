require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'

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

    cell.place_ship(cruiser)

    assert_equal cruiser, cell.ship
    assert_equal false, cell.empty?
  end

  def test_cell_can_be_fired_upon
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    cell.place_ship(cruiser)

    assert_equal false, cell.fired_upon?

    cell.fire_upon

    assert cell.fired_upon?
  end

  def test_cell_can_render_status
    cell_1 = Cell.new("B4")

    assert_equal ".", cell_1.render

    cell_1.fire_upon

    assert_equal "M", cell_1.render
  end

  def test_cell_can_run_true_render
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)

    cell_2.place_ship(cruiser)

    assert_equal ".", cell_2.render
    assert_equal "S", cell_2.render(true)
  end

  def test_a_ship_will_show_sunk_with_render
    cell_1 = Cell.new("B3")
    cell_2 = Cell.new("C3")
    cell_3 = Cell.new("D3")
    cruiser = Ship.new("Cruiser", 3)

    cell_1.place_ship(cruiser)
    cell_2.place_ship(cruiser)
    cell_3.place_ship(cruiser)
    cell_1.fire_upon

    assert_equal "H", cell_1.render
    assert_equal false, cruiser.sunk?

    cell_2.fire_upon
    cell_3.fire_upon

    assert cruiser.sunk?
    assert_equal "X", cell_1.render
  end

end
