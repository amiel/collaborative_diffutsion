# encoding: utf-8

require 'grid'
require 'floor'
require 'wall'

describe Grid do
  it 'initializes and inspects' do
    grid = Grid.build(4, 4) { Floor.new }
  end

  describe '#smell_map_for' do
    it 'returns a smell map for a particular unit' do
      grid = Grid.build(4, 4) do |row, column|
        if row == 1 && column == 2
          Floor.new Floor => 1
        else
          Floor.new
        end
      end

      grid.smell_map_for(Floor).should == Matrix[
        [0, 0, 0, 0],
        [0, 0, 1, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
      ]
    end
  end

  describe '#neighbors_for_cell' do
    let(:grid) {
      grid = Grid.build(4,4) { |row, column|
        "#{row},#{column}"
      }
    }


    it 'returns the correct neighbors' do
      grid.neighbors_for_cell(2,1).should == [
        "1,1", "2,2", "3,1", "2,0"
      ]
    end

    it 'deals with edges?' do
      grid.neighbors_for_cell(0,1).should == [
        nil, "0,2", "1,1", "0,0"
      ]
    end
  end

  describe 'iterate!' do
    it 'computes averages' do
      start_smells = Matrix[
        [0, 0, 0.0, 0],
        [0, 1, 0.8, 0],
        [0, 0, 0.4, 0],
        [0, 0, 0.0, 0],
      ]

      grid = Grid.build(4, 4) do |row, column|
        Floor.new Dude => start_smells[row, column]
      end

      new_grid = grid.iterate!
      smell_map = new_grid.smell_map_for(Dude)
      smell_map = (smell_map * 100).round
      smell_map.should == Matrix[
        [ 0, 25, 20,  0],
        [25, 20, 35, 20],
        [ 0, 35, 20, 10],
        [ 0,  0, 10,  0],
      ]

      # eventually, it dissapates
      30.times { new_grid = new_grid.iterate! }
      smell_map = new_grid.smell_map_for(Dude)
      smell_map = (smell_map * 100).round
      smell_map.should == Matrix.zero(4, 4)
    end
  end
end

