# Chungyuk Takahashi
# COSI 166b
# MazeSolver class solves a maze inputted as a map (2D array of Cells)

class MazeSolver
  attr_reader :map, :length, :width
  def initialize(args)
    @map = args[:map]
    @length = @map.length
    @width = @map[0].length
  end

  def valid_pathways(cell)
    pathways = cell.neighbors.collect do |neighbor|
      neighbor = map[neighbor[:x_coord]][neighbor[:y_coord]]
    end
    pathways.select do |neighbor| !cell.wall?(neighbor) end
  end

  # Use breadth first search to find the shortest path from point A to point B
  def solve(args)
    @seen_stack, @need_to_check, solved = [], [], false
    current_cell, finish = map[args[:begX]][args[:begY]], map[args[:endX]][args[:endY]]
    @seen_stack.push(current_cell)
    @need_to_check.push(current_cell)

    until @need_to_check.empty? || solved
      current_cell = @need_to_check.shift
      @seen_stack.push(current_cell)
      check_possible_paths(current_cell, finish)
      solved = true if current_cell == finish
    end
    solved
  end

  def check_possible_paths(current_cell, finish)
    valid_pathways(current_cell).each do |neighbor_cell|
      unless @seen_stack.include?(neighbor_cell) || current_cell == finish
        @need_to_check.push(neighbor_cell)
      end
    end
  end

  # Takes the stack of seen Cells and creates direct path
  def trace(args)
    if solve(args)
      path_stack, current_cell = [], @seen_stack.last
      path_stack.push(current_cell)
      until @seen_stack.empty?
        current_cell = find_steps(current_cell, path_stack)
      end
      path_stack.reverse.each { |cell| print "-->#{cell} " }
      puts ""
      path_stack
    else nil
    end
  end

  def find_steps(current_cell, path_stack)
    current_cell = @seen_stack.pop
    last_in_path = path_stack.last
    if current_cell.neighbor?(last_in_path) && !current_cell.wall?(last_in_path)
      path_stack.push(current_cell)
    end
    current_cell
  end

end
