require 'grid_builder'

describe GridBuilder do
  it 'parses a stream' do
    builder = GridBuilder.new StringIO.new <<-GRID
|---|
| | |
|---|
GRID

    builder.grid.matrix.collect(&:inspect).should == Matrix[
      ['Wall()', 'Wall()', 'Wall()', 'Wall()', 'Wall()'],
      ['Wall()', 'Floor()', 'Wall()', 'Floor()', 'Wall()'],
      ['Wall()', 'Wall()', 'Wall()', 'Wall()', 'Wall()'],
    ]
  end
end
