require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'

class BoardTest < MiniTest::Test

  def test_it_exists
    board = Board.new

    assert_instance_of Board, board
  end

  def test_board_creation_initializes_16_cells
    board = Board.new
    board.cells

    # test a hash with 
  end

  def method_name

  end

end
