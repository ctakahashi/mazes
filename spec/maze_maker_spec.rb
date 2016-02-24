require 'rspec'
require_relative '../maze_maker'
require 'rack/test'

describe "MazeMaker" do

  before(:all) do
    @maze_maker = MazeMaker.new(:width=>3, :length=>5)
    @cell = @maze_maker.map[0][0]

  end

  it "should have length and width" do 
    @maze_maker.should be_an_instance_of MazeMaker
    @maze_maker.length.should == 5
    @maze_maker.width.should == 3
  end

  it "should make a base for the maze" do 
    @maze_maker.map.should be_an_instance_of Array
  end

  it "should return unseen neighbors" do
    @maze_maker.unseen_neighbors(@cell).size.should == 2
    @maze_maker.map[1][0].see
    @maze_maker.unseen_neighbors(@cell).size.should == 1
  end

  it "should create walls between a cell and surrounding, seen cells" do
    @cell.south_wall.should == false
    @maze_maker.create_walls(@cell)
    @cell.south_wall.should == true
  end

end