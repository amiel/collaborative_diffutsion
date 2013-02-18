require 'matrix'

class Grid
  attr_reader :matrix

  def initialize(matrix)
    @matrix = matrix
  end

  def self.build(width, height, &blk)
    new Matrix.build(width, height, &blk)
  end

  def smell_map_for(unit)
    @matrix.collect do |cell|
      cell.smell_for(unit)
    end
  end

  def padded_matrix
    Matrix.build(@matrix.row_size + 2, @matrix.column_size + 2) do |row, column|
      if row < 1 || column < 1
        nil
      else
        @matrix[row - 1, column - 1]
      end
    end
  end

  def neighbors_for_cell(row, column)
    padded_matrix.minor(row, 3, column, 3)
  end

  def neighbors_for_tile(tile)
    neighbors_for_cell *@matrix.index(tile)
  end

  def iterate!
    new_matrix = @matrix.collect do |tile|
      tile.iterate! self
    end

    self.class.new new_matrix
  end
end

