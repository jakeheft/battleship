class Cell
  attr_reader :coordinate, :ship, :fired_status

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_status = false
  end

  def empty?
    @ship == nil
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    @fired_status
  end

  def fire_upon
    @fired_status = true
    if empty? == false
      @ship.hit
    end
  end

  def render(reveal = false)
    if reveal == true
      if !empty? && !fired_upon?
        "S"
      elsif !empty? && @ship.sunk?
        "X"
      elsif !empty? && fired_upon?
        "H"
      elsif empty? && fired_upon?
        "M"
      elsif empty? && !fired_upon?
        "."
      end
    elsif reveal == false
      if !fired_upon?
        "."
      elsif empty? && fired_upon?
        "M"
      elsif !empty? && @ship.sunk?
        "X"
      elsif !empty? && fired_upon?
        "H"
      end
    end
  end
end
