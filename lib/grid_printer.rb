require 'grid'

class GridPrinter
  def initialize(grid, stream = STDOUT)
    @grid, @stream = grid, stream
  end

  def write
    @grid.matrix.each_with_index do |tile, row, column|
      @stream << tile.char
      @stream << "\n" if column == @grid.matrix.column_size - 1
    end
  end
end


