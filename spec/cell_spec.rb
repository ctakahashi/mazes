require 'rspec'
require_relative '../cell'
require 'rack/test'

describe "Cell" do

  before(:all) do 
    @cell = Cell.new(:x_coord=>0, :y_coord=>0, :length => 4, :width=>4)
    @other_cell = Cell.new(:x_coord=>0, :y_coord=>1, :length=>4, :width=>4)
  end

	it "should have an x and y coordinate" do
    @cell.x_coord.should == 0
    @cell.x_coord.should == 0
  end

  it "should have walls" do
    @cell.top_edge
    @cell.left_edge
    @cell.bottom_edge
    @cell.right_edge
    @cell.north_wall.should == true
    @cell.west_wall.should == true
    @cell.south_wall.should == false
    @cell.east_wall.should == false
  end

  it "should add valid neighbors" do
    @cell.add_neighbors
    @cell.neighbors.size.should == 2
  end

  it "should be track if seen or not" do
    @cell.see
    @cell.seen.should == true
    @cell.unsee
    @cell.seen.should == false
  end

  it "should check if two cells are neighbors" do 
    @cell.neighbor?(@other_cell).should == true
  end

  it "should check if there is a wall between the two cells" do 
    @cell.wall?(@other_cell).should == false
  end
end