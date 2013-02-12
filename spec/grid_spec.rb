require 'grid'

describe Grid do
  it 'initializes and inspects' do
    grid = Grid.new(4, 4) { Floor.new }
  end

  describe '#smell_map_for' do
    it 'returns a smell map for a particular unit' do
      grid = Grid.new(4, 4) do |row, column|
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
    it 'returns the correct neighbors' do
      grid = Grid.new(4,4) { |row, column|
        "#{row},#{column}"
      }

      grid.neighbors_for_cell(2,1).should == Matrix[
        ["1,0", "1,1", "1,2"],
        ["2,0", "2,1", "2,2"],
        ["3,0", "3,1", "3,2"],
      ]
    end
  end

  describe 'iterate!' do
    it 'computes averages' do
      start_smells = Matrix[
        [0, 0, 0.0, 0],
        [0, 1, 0.8, 0],
        [0, 0, 0.9, 0],
        [0, 0, 0.0, 0],
      ]

      grid = Grid.new(4, 4) do |row, column|
        Floor.new Dude => start_smells[row, column]
      end

      new_grid = grid.iterate!
      smell_map = new_grid.smell_map_for(Dude)
      smell_map  = (smell_map * 100).round
      smell_map.should == Matrix[
        [0,  0,  0,  0],
        [0, 30, 30, 19],
        [0, 30, 30, 19],
        [0, 10, 10, 10],
      ]

      30.times { new_grid = new_grid.iterate! }
      smell_map = new_grid.smell_map_for(Dude)
      smell_map  = (smell_map * 100).round
      smell_map.should == Matrix.zero(4, 4)
    end
  end
end


describe GridUnit do
  it 'inspects smells' do
    unit = GridUnit.new GridUnit => 4, Floor => 3
    unit.inspect.should == 'GridUnit(G:4,F:3)'
  end

  describe '#smell_for' do
    it 'returns the smell of a unit' do
      unit = GridUnit.new Floor => 2
      unit.smell_for(Floor).should == 2
    end

    it 'returns 0 if a unit does not exist' do
      unit = GridUnit.new
      unit.smell_for(Floor).should == 0
    end
  end

end

describe Floor do
  describe 'iterate!' do
    it 'calculates the average of all its neighbors' do
      tile = Floor.new
      new_tile = tile.iterate! Matrix[
        [Floor.new(Dude => 1), Floor.new(Dude => 0.8), Floor.new],
        [Floor.new, tile, Floor.new(Enemy => 0.9)],
        [nil, nil, nil],
      ]

      new_tile.smells.should == {
        Dude => 1.8/9,
        Enemy => 0.9/9,
      }
    end
  end

end
