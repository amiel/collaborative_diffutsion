require 'grid'
require 'floor'
require 'thing'
require 'wall'

describe Floor do
  describe '#iterate!' do
    it 'calculates the average of all its neighbors' do
      tile = Floor.new

      grid = Grid.new Matrix[]
      grid.should_receive(:neighbors_for_tile).with(tile).and_return [
        Floor.new(nil, Dude => 1),
        Floor.new(nil, Dude => 0.8, Enemy => 1.2),
        Floor.new(nil, Enemy => 1.2),
        nil,
      ]

      new_tile = tile.iterate! grid
      new_tile.smells.should == {
        Dude => 1.8/4,
        Enemy => 2.4/4,
      }
    end

    context 'with a thing' do
      it 'always has a smell of 1 for the thing' do
        tile = Floor.new Dude.new
        grid = Grid.new Matrix[]

        grid.should_receive(:neighbors_for_tile).with(tile).and_return [
          Floor.new,
          Floor.new(nil, Dude => 0.8, Enemy => 1.2),
          Floor.new(nil, Enemy => 1.2),
          nil,
        ]

        new_tile = tile.iterate! grid
        new_tile.smells.should == {
          Dude => 1,
          Enemy => 2.4/4,
        }
      end

      it 'always has a smell of 1 for the thing even if it has no smells' do
        tile = Floor.new Dude.new
        grid = Grid.new Matrix[]

        grid.should_receive(:neighbors_for_tile).with(tile).and_return [
          Floor.new,
          Floor.new,
          Wall.new,
          nil,
        ]

        new_tile = tile.iterate! grid
        new_tile.smells.should == {
          Dude => 1,
        }
      end


    end
  end

  describe '#char' do
    it 'is blank' do
      Floor.new.char.should == ' '
    end

    context 'with a thing' do
      it 'is the things char' do
        f = Floor.new stub(:thing, char: '*')
        f.char.should == '*'
      end
    end
  end

end
