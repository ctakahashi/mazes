# Chungyuk Takahashi
# COSI 166b
require './cell.rb'

# Creates the map of Cells for a maze
class MazeMaker
  attr_reader :width, :length, :map
  def initialize(args)
    @width = args[:width]
    @length = args[:length]
    make_base
  end

  # Add outside borders that maps should have
  def add_map_edges
    map.each do |row|
      add_row_edges(row)
    end
  end

  def add_row_edges(row)
    row.each do |cell|
      cell.top_edge
      cell.bottom_edge
      cell.left_edge
      cell.right_edge
    end
  end

  # Make base of the maze (Initializes the 2D array of Cells)
  def make_base
    @map = Array.new(length) { |x_coord|
      Array.new(width) { |y_coord| Cell.new(:x_coord => x_coord, :y_coord => y_coord, :length => length, :width => width) }
    }
    add_map_edges
    @map
  end

  def unseen_neighbors(cell)
    neighbors = cell.neighbors.select { |neighbor|
      !@map[neighbor[:x_coord]][neighbor[:y_coord]].seen
    }
  end

  def create_walls(cell)
    cell.neighbors.each do |neighbor_coord|
      neighbor_cell = map[neighbor_coord[:x_coord]][neighbor_coord[:y_coord]]
      if neighbor_cell.seen
        direction = neighbor_coord[:dir]
        if cell.create_wall(direction)
          neighbor_cell.create_wall((direction + 2) % 4)
        end
      end
    end
  end

  # Uses Recursive backtracking to create the maze
  def redesign
    @record_stack = []
    current_cell = @map.sample.sample
    current_cell.see
    @record_stack.push(current_cell)
    until @record_stack.empty?
      current_cell = redesign_algorithm(current_cell)
    end
  end

  def redesign_algorithm(current_cell)
    until unseen_neighbors(current_cell).empty?
      @record_stack.push(current_cell)
      current_cell = next_generated_cell(current_cell)
    end
    while unseen_neighbors(current_cell).empty? && !@record_stack.empty?
      current_cell = @record_stack.pop
    end
    return current_cell
  end

  def next_generated_cell(current_cell)
    rand_neighbor = unseen_neighbors(current_cell).sample
    current_cell = @map[rand_neighbor[:x_coord]][rand_neighbor[:y_coord]]
    current_cell.see
    current_cell.prev_cell = (rand_neighbor[:dir] + 2) % 4
    create_walls(current_cell)
    current_cell
  end

  # Algorithm goes through all Cells to create a random number of walls for each one.
  def rand_redesign
    map.each do |row|
      row.each do |cell|
        possible_num_of_walls = rand(4)
        create_rand_walls(cell, possible_num_of_walls)
      end
    end
  end

  def create_rand_walls(cell, num_of_walls)
    num_of_walls.times do
      direction = rand(4)
      if cell.create_wall(direction)
        attempt_create_wall(cell, direction)
      end
    end
  end

  def attempt_create_wall(cell, direction)
    neighbor = cell.neighbors[direction]
    begin
      neighbor_cell = map[neighbor[:x_coord]] [neighbor[:y_coord]]
      neighbor_cell.create_wall((direction + 2) % 4)
    rescue
    end
  end

end
