require 'thing'
require 'floor'

describe Dude do

end

describe Enemy do
  describe '#move_to?' do
    it 'picks the tile with the highest smell for the dude' do
      neighbors = [
        Floor.new(nil, Dude => 0.25),
        Floor.new(nil, Dude => 0.15),
        Floor.new(nil, Dude => 0.05),
        Floor.new(nil, Dude => 0.15),
      ]

      Enemy.new.move_to?(neighbors).should == neighbors[0]
    end

    it 'prefers to stay away from other enemies' do
      neighbors = [
        Floor.new(nil, Dude => 0.25, Enemy => 0.5),
        Floor.new(nil, Dude => 0.15, Enemy => 0.05),
        Floor.new(nil, Dude => 0.05, Enemy => 0),
        Floor.new(nil, Dude => 0.15, Enemy => 0.15),
      ]

      Enemy.new.move_to?(neighbors).should == neighbors[1]
    end
  end
end
