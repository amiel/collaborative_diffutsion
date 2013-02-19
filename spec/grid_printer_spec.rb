# encoding: utf-8

require 'grid_printer'
require 'wall'
require 'floor'

describe GridPrinter do
  describe '#print' do
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
  end

end
