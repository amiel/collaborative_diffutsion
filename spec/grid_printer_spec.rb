# encoding: utf-8

require 'grid_printer'
require 'wall'
require 'floor'
require 'thing'
require 'grid_builder'

describe GridPrinter do
  describe '#write' do
    it 'prints a grid?' do
      grid = Grid.new Matrix[
        [Wall.new, Wall.new, Wall.new, Wall.new, Wall.new],
        [Wall.new, Floor.new, Wall.new, Floor.new, Wall.new],
        [Wall.new, Wall.new, Wall.new, Wall.new, Wall.new],
        [Wall.new, Floor.new, Wall.new, Floor.new, Wall.new],
        [Wall.new, Floor.new, Floor.new, Floor.new, Wall.new],
        [Wall.new, Wall.new, Wall.new, Wall.new, Wall.new],
      ]

      buffer = ''
      grid_printer = GridPrinter.new(grid, buffer)
      grid_printer.write

      expected = <<-GRID
┌─┬─┐
│ │ │
├─┼─┤
│ ╵ │
│   │
└───┘
GRID

      buffer.should == expected
    end

    it 'colors!' do
      grid = Grid.new Matrix[
        [Wall.new, Wall.new, Wall.new, Wall.new, Wall.new],
        [Wall.new, Floor.new, Wall.new, Floor.new, Wall.new],
        [Wall.new, Floor.new(Dude.new), Wall.new, Floor.new, Wall.new],
        [Wall.new, Floor.new, Floor.new, Floor.new, Wall.new],
        [Wall.new, Wall.new, Wall.new, Wall.new, Wall.new],
      ]


      10.times { grid = grid.iterate! }
      puts
      grid_printer = GridPrinter.new(grid)
      grid_printer.write

    end

    it 'colors 2!' do
      builder = GridBuilder.new File.open('spec/fixtures/1')
      grid = builder.grid

      puts
      200.times { grid = grid.iterate! }
      grid_printer = GridPrinter.new(grid)
      grid_printer.write
    end
  end

end
