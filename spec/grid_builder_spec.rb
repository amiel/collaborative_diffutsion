require 'grid_builder'

describe GridBuilder do
  it 'splits up a file' do
    builder = GridBuilder.new StringIO.new <<-GRID
|---|
| | |
|---|
GRID

    builder.grid.matrix.collect(&:class).should == Matrix[
      [Wall, Wall, Wall, Wall, Wall],
      [Wall, Floor, Wall, Floor, Wall],
      [Wall, Wall, Wall, Wall, Wall],
    ]
  end
end
