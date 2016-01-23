require_relative '../board'

describe Board do 
	cell = Cell.new
	cell.neighbors.count.should == 0
end