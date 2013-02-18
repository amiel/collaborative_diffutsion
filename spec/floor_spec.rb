require 'grid'
require 'floor'

describe Floor do
  describe 'iterate!' do
    it 'calculates the average of all its neighbors' do
      tile = Floor.new
      new_tile = tile.iterate! Grid.new(Matrix[
        [Floor.new(Dude => 1), Floor.new(Dude => 0.8), Floor.new],
        [Floor.new, tile, Floor.new(Enemy => 0.9)],
        [nil, nil, nil],
      ])

      new_tile.smells.should == {
        Dude => 1.8/9,
        Enemy => 0.9/9,
      }
    end
  end

end
