require 'rspec'
require_relative '../maze'
require 'rack/test'

describe "Maze" do

  before(:all) do
    @maze = Maze.new(:width => 4, :length => 4)
  end

	it "should have a length and width" do 
    # maze = Maze.new(:width => 4, :length => 5)
    @maze.length.should == 4
    @maze.width.should == (4)
  end

  it "should load a maze map" do
    @maze = Maze.new(:width => 4, :length => 4)
    @maze.load("111111111100010001111010101100010101101110101100000101111011101100000101111111111")
    @maze.display.should == "111111111100010001111010101100010101101110101100000101111011101100000101111111111"
  end

  it "should try to find a possible solution" do
    maze = Maze.new(:width => 4, :length => 4)
    maze.load("111111111100010001111010101100010101101110101100000101111011101100000101111111111")
    maze.solve(:begX => 0, :begY=>0, :endX=> 3, :endY=>3).should == true
  end

  it "should find no possible solution" do
    maze = Maze.new(:width=>4, :length=>4)
    maze.load("111111111101000001101110101100010101101111111100010101101111111100010001111111111")
    maze.solve(:begX=>0, :begY=>0, :endX=>3, :endY=>3).should == false
  end

end