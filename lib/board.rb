class Board
  attr_reader :cells

  def initialize
    @cells = {
      "A1" => Cell.new("A1"),
      "A2" => Cell.new("A2"),
      "A3" => Cell.new("A3"),
      "A4" => Cell.new("A4"),
      "B1" => Cell.new("B1"),
      "B2" => Cell.new("B2"),
      "B3" => Cell.new("B3"),
      "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"),
      "C2" => Cell.new("C2"),
      "C3" => Cell.new("C3"),
      "C4" => Cell.new("C4"),
      "D1" => Cell.new("D1"),
      "D2" => Cell.new("D2"),
      "D3" => Cell.new("D3"),
      "D4" => Cell.new("D4"),
    }
  end

  def validate_coordinate?(cell)
    @cells.keys.include?(cell)
  end

  def validate_coordinates?(coordinates)
    coordinates.each.all? do |coordinate|
      validate_coordinate?(coordinate)
    end
  end

  def consecutive_coordinates?(coordinates)
    letters = []
    numbers = []
    coordinates.each do |coordinate|
      letters << coordinate[0].ord
      numbers << coordinate[1].to_i
    end
    if letters.sort.each_cons(2).all? { |x,y| x == y} && numbers.sort.each_cons(2).all? { |x,y| x == y - 1 }
      true
    elsif numbers.sort.each_cons(2).all? { |x,y| x == y} && letters.sort.each_cons(2).all? { |x,y| x == y - 1 }
      true
    else
     false
   end
  end

  def coordinates_empty?(coordinates)
    coordinates.select.all? do |coordinate|
      cells[coordinate].empty?
    end
  end

  def valid_placement?(ship, coordinates)
    coordinates.length == ship.length && consecutive_coordinates?(coordinates) &&
     validate_coordinates?(coordinates) && coordinates_empty?(coordinates)
  end

  def place(ship, coordinates)
    coordinates.each do |coordinate|
      cells[coordinate].place_ship(ship)
    end
  end

  def render(reveal = false)
    if reveal == false
      #cra = "Coordinates Render Array"
      cra = cells.map do |key, value|
        value.render
      end
    elsif reveal == true
      cra = cells.map do |key, value|
        value.render(true)
      end
    end
    "  1 2 3 4 ""\nA #{cra[0]} #{cra[1]} #{cra[2]} #{cra[3]} \nB #{cra[4]} #{cra[5]} #{cra[6]} #{cra[7]} \nC #{cra[8]} #{cra[9]} #{cra[10]} #{cra[11]} \nD #{cra[12]} #{cra[13]} #{cra[14]} #{cra[15]} \n"
  end

  def has_lost?
    sunk_cells = @cells.find_all do |key, cell|
      cell.render == "X"
    end
    if sunk_cells.length == 5
      true
    else
      false
    end
  end

end
