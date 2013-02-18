require 'grid'
require 'floor'

describe Floor do
  describe 'iterate!' do
    it 'calculates the average of all its neighbors' do
      tile = Floor.new

      grid = Grid.new Matrix[]
      grid.should_receive(:neighbors_for_tile).with(tile).and_return [
        Floor.new(Dude => 1),
        Floor.new(Dude => 0.8, Enemy => 1.2),
        Floor.new(Enemy => 1.2),
        nil,
      ]

      new_tile = tile.iterate! grid
      new_tile.smells.should == {
        Dude => 1.8/4,
        Enemy => 2.4/4,
      }
    end
  end

end
