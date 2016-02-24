# Chungyuk Takahashi
# COSI 166b 
# Cell class that represents a single cell in a maze

class Cell

  attr_reader :x_coord, :y_coord, :map_length, :map_width, :seen, :north_wall, :east_wall, :south_wall, :west_wall, :neighbors
  attr_accessor :prev_cell

  def initialize(args)
    @x_coord    = args[:x_coord]
    @y_coord    = args[:y_coord]
    @map_length = args[:length]
    @map_width  = args[:width]
    @seen       = false
    @north_wall, @east_wall, @south_wall, @west_wall = false, false, false, false
    @prev_cell  = nil
    @neighbors  = add_neighbors
  end

  def see
    @seen = true
  end

  def unsee
    @seen = false
  end

  def top_edge(value=nil)
    @north_wall = true  if x_coord == 0 || value == "1"
  end

  def right_edge(value=nil)
    @east_wall = true if y_coord == map_width - 1 || value == "1"
  end

  def bottom_edge(value=nil)
    @south_wall = true if x_coord == map_length - 1 || value == "1"
  end

  def left_edge(value=nil)
    @west_wall = true if y_coord == 0 || value == "1"
  end

  def valid_cell?(cell_as_hash)
    valid = true
    cell_x = cell_as_hash[:x_coord]
    cell_y = cell_as_hash[:y_coord]
    valid = false if cell_x < 0 || cell_y < 0 || cell_x >= map_length || cell_y >= map_width
    valid
  end

  # Add a hash with the coordinates and the direction of the neighbors (not Cell object) of current cell
  def add_neighbors
    neighbors = []
    neighbors.push(:x_coord => x_coord - 1, :y_coord => y_coord, :dir => 0)
    neighbors.push(:x_coord => x_coord, :y_coord => y_coord - 1, :dir => 1)
    neighbors.push(:x_coord => x_coord + 1, :y_coord => y_coord, :dir => 2)
    neighbors.push(:x_coord => x_coord, :y_coord => y_coord + 1, :dir => 3)
    neighbors = neighbors.select { |neighbor|
      valid_cell?(neighbor)
    }
  end

  def neighbor?(other_cell)
    if (self.x_coord - other_cell.x_coord).abs + (self.y_coord - other_cell.y_coord).abs == 1 then true
    else false
    end
  end

  # Create a wall in a certain direction
  def create_wall(direction)
    unless direction == @prev_cell
      case direction
      when 0 then top_edge("1")
      when 1 then left_edge("1")
      when 2 then bottom_edge("1")
      when 3 then right_edge ("1")
      end
    end
  end

  def wall?(neighbor)
    if neighbor?(neighbor)
      neighbor_x = neighbor.x_coord
      neighbor_y = neighbor.y_coord
      if x_coord > neighbor_x then north_wall
      elsif y_coord > neighbor_y then west_wall
      elsif x_coord < neighbor_x then south_wall
      elsif y_coord < neighbor_y then east_wall
      else raise "Not even a neighbor!"
      end
    else
      false
    end
  end

  def to_s
    "x: #{x_coord}, y: #{y_coord}"
  end

end
