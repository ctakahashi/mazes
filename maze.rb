# Chungyuk Takahashi
# COSI 166b 
# Maze generating program
require './cell.rb'
require './maze_maker.rb'
require './maze_solver.rb'
# require 'pry'

# Creates a maze object which mainly prints the maze
# Other commands are mainly implemented with other classes
class Maze
  attr_reader :width, :length, :map, :map_as_string
  def initialize(args)
    @width = args[:width]
    @length = args[:length]
    @maze_maker = MazeMaker.new(:width => width, :length => length)
    @map = @maze_maker.map
    @map_as_string = ""
  end

  def load(arg)
    @map, @map_as_string = @maze_maker.make_base, arg
    @map.each do |cell_row|
      load_row(arg, cell_row)
    end
  end

  def load_row(arg, cell_row)
    cell_row.each do |cell|
      cell_x = (cell.x_coord * 2 + 1) * (width * 2 + 1)
      cell_y = cell.y_coord * 2 + 1
      load_walls(arg, cell, cell_x + cell_y)
    end
  end

  def load_walls(arg, cell, cell_coord)
    row_diff = (width * 2 + 1)
    cell.top_edge(arg[cell_coord - row_diff])
    cell.left_edge(arg[cell_coord - 1])
    cell.bottom_edge(arg[cell_coord + row_diff])
    cell.right_edge(arg[cell_coord + 1])
  end

  def create_row(row, path=nil)
    @horiz_walls, @vert_walls = "", ""
    create_horiz_walls(row, path)
    @horiz_walls += "+\n"
    @vert_walls += "|\n"
    return @horiz_walls, @vert_walls
  end

  def create_horiz_walls(row, path)
    row.each do |cell|
      @horiz_walls += cell.north_wall ? "+--" : "+  "
      create_vert_wall(path, cell)
    end
  end

  def create_vert_wall(path, cell)
    west_wall = cell.west_wall
    if path && path.include?(cell) then @vert_walls += west_wall ? "|@ " : " @ "
    else @vert_walls += west_wall ? "|  " : "   " end
  end

  def display(path=nil)
    @map_as_string = ""
    create_string_walls(path)
    @map_as_string += "+\n"
    puts @map_as_string
    @map_as_string.gsub!('+', '1').gsub!('--', '1').gsub!('|', '1').gsub!('   ', '00').gsub!('  ', '0').gsub!("\n", "")
  end

  def create_string_walls(path)
    @map.each do |row|
      @horiz_walls, @vert_walls = create_row(row, path)
      @map_as_string += @horiz_walls + @vert_walls
    end
    (width).times do @map_as_string += "+--" end
  end

  def solve(args)
    args[:map] = @map
    @solver = MazeSolver.new(args)
    @solver.solve(args)
  end

  def trace(args)
    args[:map] = @map
    @solver = MazeSolver.new(args)
    display(@solver.trace(args))
  end

  def redesign(design_choice=0)
    @maze_maker.make_base
    if design_choice < 1 then @maze_maker.redesign
    elsif design_choice > 0 then @maze_maker.rand_redesign
    else raise "Error, inputted argument is not of FixNum class"
    end
    @map = @maze_maker.map
  end
end
