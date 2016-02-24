# Chungyuk Takahashi
# COSI 166b
# Client file for the Maze class

require './maze.rb'

def promptForNum
  num = 0
  loop do
    num = $stdin.gets.chomp
    if (Integer(num) rescue false)
      break
    else
      puts "Invalid, try again"
    end
  end
  num
end

loop do
  puts "Would you like to make a new maze? (y/n)"
  input = $stdin.gets.chomp
  break if input.include? 'n'
  # length = 0
  # width = 0

  # @new_maze = Maze.new(:length=> 0, :width => 0)

  puts "Would you like to load your own map? (y/n)"
  input = $stdin.gets.chomp
  loop do
    if input.include? 'y'
      puts "Please input your binary string:"
      input = $stdin.gets.chomp
      @length = 1
      element = input[0]
      until element == '0'
        element = input[@length]
        @length += 1
      end
      puts @width
      @width = input.size / (@length - 2) / 2
      @length = (@length - 2) / 2
      puts @width
      @new_maze = Maze.new(:length=> @length, :width => @width)
      @new_maze.load(input)
      break
    elsif input.include? 'n'
      puts "Please enter the length(int) of the maze"
      @length = promptForNum().to_i
      puts "Please enter the width(int)"
      @width = promptForNum().to_i
      @new_maze = Maze.new(:length=> @length, :width => @width)
      puts "Would you like a totally random and possibly invalid maze (y/n)"
      input = $stdin.gets.chomp
      loop do
        if input.include? 'y'
          @new_maze.redesign(1)
          break
        elsif input.include? 'n'
          @new_maze.redesign
          break
        else
          puts "Enter a valid response"
        end
      end
      break
    else
      puts "Enter a valid response"
    end
  end

  puts "Here is your new maze"
  @new_maze.display
  loop do
    puts "Please enter startX, startY, endX, endY for a possible solution"
    puts "(x: 0-#{@width-1}, y: 0-#{@length-1})"
    puts "To stop, enter 'q'"
    input = $stdin.gets.chomp
    input = input.split(/[\s,]+/)
    if input[0].include? 'q'
      puts "Thanks for playing!"
      break
    elsif input.size == 4
      # input.collect! { |coord| coord = coord.to_i }
      args = {:begX => input[0].to_i, :begY => input[1].to_i,
         :endX => input[3].to_i, :endY => input[2].to_i}
      puts args.class
      if @new_maze.solve(args)
        @new_maze.trace(args)
      else
        puts "Sorry, there is no possible path for the given input for this maze"
      end
    else
      puts "Enter a valid response"
    end
  end

end
