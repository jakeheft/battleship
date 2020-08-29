class Computer
  attr_reader :cells
  
  def initialize
    @cells = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
  end

  def valid_placement?(ship_length, randomizer, starting_cell)
    starting_letter = starting_cell[0]
    starting_num = starting_cell[1].to_i
    rest_of_ship_length = ship_length - 1
    if randomizer == "horizontal" && (starting_num + rest_of_ship_length) <= 4
      true
    elsif randomizer == "vertical" && ((starting_letter.ord - 64) + rest_of_ship_length) <= 4
      true
    else
      false
    end
  end

  def query_place_ship(ship_length)
    randomizer = ["vertical", "horizontal"].sample
    starting_cell = @cells.sample
    until valid_placement?(ship_length, randomizer, starting_cell)
      starting_cell = @cells.sample
    end
    coordinates_of_ship = [starting_cell]
    if randomizer == "vertical"
      (ship_length - 1).times do
        next_cell = (starting_cell[0].ord + 1).chr + starting_cell[1]
        coordinates_of_ship << next_cell
        starting_cell = next_cell
      end
    elsif randomizer == "horizontal"
      (ship_length - 1).times do
        next_cell = starting_cell[0] + (starting_cell[1].to_i + 1).to_s
        coordinates_of_ship << next_cell
        starting_cell = next_cell
      end
    end
  coordinates_of_ship
  end

  def query_fire_upon
    @cells = @cells.shuffle
    @cells.shift
  end
end
