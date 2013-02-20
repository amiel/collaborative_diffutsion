require 'tile'

class Floor < Tile;end


describe Tile do
  it 'inspects smells' do
    unit = Tile.new nil, Tile => 4, Floor => 3
    unit.inspect.should == 'Tile(T:4,F:3)'
  end

  describe '#smell_for' do
    it 'returns the smell of a unit' do
      unit = Tile.new nil, Floor => 2
      unit.smell_for(Floor).should == 2
    end

    it 'returns 0 if a unit does not exist' do
      unit = Tile.new
      unit.smell_for(Floor).should == 0
    end
  end

end
