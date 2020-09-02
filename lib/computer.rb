class Computer
  attr_reader :placement_cells, :firing_cells, :direction

  def initialize
    @placement_cells = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
    @firing_cells = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
    @direction = ""
  end

  def randomizer
    ["vertical", "horizontal"].sample
  end

  def horizontal?
    @direction == "horizontal"
  end

  def valid_placement?(ship_length, starting_cell)
    @direction = randomizer
    starting_letter = starting_cell[0]
    starting_num = starting_cell[1].to_i
    rest_of_ship_length = ship_length - 1
    if horizontal? && (starting_num + rest_of_ship_length) <= 4
      true
    elsif !horizontal? && ((starting_letter.ord - 64) + rest_of_ship_length) <= 4
      true
    else
      false
    end
  end

  def delete_occupied_cells(coordinates)
    coordinates.map do |cell|
      @placement_cells.delete(cell)
    end
  end

  def vertical_ship_coordinates(ship_length, starting_cell)
    coordinates_of_ship = [starting_cell]
    (ship_length - 1).times do
      next_cell = (starting_cell[0].ord + 1).chr + starting_cell[1]
      coordinates_of_ship << next_cell
      starting_cell = next_cell
    end
    delete_occupied_cells(coordinates_of_ship) if ship_length == 3
    coordinates_of_ship
  end

  def horizontal_ship_coordinates(ship_length, starting_cell)
    coordinates_of_ship = [starting_cell]
    (ship_length - 1).times do
      next_cell = starting_cell[0] + (starting_cell[1].to_i + 1).to_s
      coordinates_of_ship << next_cell
      starting_cell = next_cell
    end
    delete_occupied_cells(coordinates_of_ship) if ship_length == 3
    coordinates_of_ship
  end

  def query_place_ship(ship_length)
    starting_cell = @placement_cells.sample
    until valid_placement?(ship_length, starting_cell)
      starting_cell = @placement_cells.sample
    end
    if !horizontal?
      vertical_ship_coordinates(ship_length, starting_cell)
    elsif horizontal?
      horizontal_ship_coordinates(ship_length, starting_cell)
    end
  end

  def query_fire_upon
    @firing_cells = @firing_cells.shuffle
    @firing_cells.shift
  end

  def query_consecutive_cell(coordinates)
    consecutive_cell_array = []
    coordinates.each do |coordinate|
      cell_letter = coordinate[0]
      cell_number = coordinate[1].to_i
      consecutive_cell_array << (cell_letter + (cell_number + 1).to_s)
      consecutive_cell_array << (cell_letter + (cell_number - 1).to_s)
      consecutive_cell_array << (cell_letter.ord + 1).chr + cell_number.to_s
      consecutive_cell_array << (cell_letter.ord - 1).chr + cell_number.to_s
    end
    valid_cells = consecutive_cell_array & @firing_cells
    firing_cell = valid_cells.sample
    @firing_cells.delete(firing_cell)
    firing_cell
  end
end
