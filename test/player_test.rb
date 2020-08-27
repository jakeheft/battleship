require "minitest/autorun"
require "minitest/pride"
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/player'

class PlayerTest < Minitest::Test
  def test_it_exists
    player = Player.new("Timmy")

    assert_instance_of Player, player
  end

end
