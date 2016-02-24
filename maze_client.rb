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
  puts "Please enter the length(int) of the maze"
  length = promptForNum().to_i
  puts "Please enter the width(int)"
  width = promptForNum().to_i
  new_maze = Maze.new(:length=> length, :width => width)

  puts "Would you like to load your own map? (y/n)"
  input = $stdin.gets.chomp
  loop do
    if input.include? 'y'
      puts "Please input your binary string:"
      input = $stdin.gets.chomp
      new_maze.load(input)
      break
    elsif input.include? 'n'
      puts "Would you like a totally random and possibly invalid maze (y/n)"
      input = $stdin.gets.chomp
      loop do
        if input.include? 'y'
          new_maze.redesign(1)
          break
        elsif input.include? 'n'
          new_maze.redesign
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
  new_maze.display
  loop do
    puts "Please enter startX, startY, endX, endY for a possible solution"
    puts "(x: 0-#{width-1}, y: 0-#{length-1})"
    puts "To stop, enter 'q'"
    input = $stdin.gets.chomp
    input = input.split(/[\s,]+/)
    if input[0].include? 'q' then break
    elsif input.size == 4
      input.collect! { |coord| coord = coord.to_i }
      if new_maze.solve(:begX => input[0], :begY => input[1], :endX => input[2], :endY => input[3])
        new_maze.trace(:begX => input[0], :begY => input[1], :endX => input[2], :endY => input[3])
      else
        puts "Sorry, there is no possible path for the given input for this maze"
      end
    else
      puts "Enter a valid response"
    end
  end

end
