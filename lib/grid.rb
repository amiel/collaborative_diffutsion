require 'matrix'

class Grid
  attr_reader :matrix

  def initialize(matrix)
    @matrix = matrix
    @matrix.each do |t|
      t.grid = self if t.respond_to?(:grid=)
    end
  end

  def self.build(width, height, &blk)
    new Matrix.build(width, height, &blk)
  end

  def smell_map_for(unit)
    @matrix.collect do |cell|
      cell.smell_for(unit)
    end
  end

  def [](row, column)
    if row < 0 || column < 0 || row >= @matrix.row_size || column >= @matrix.column_size
      nil # TODO: EdgeTile
    else
      @matrix[row, column]
    end
  end

  def neighbors_for_cell(row, column)
    [
      self[row - 1, column], # Top
      self[row, column + 1], # Right
      self[row + 1, column], # Bottom
      self[row, column - 1], # Left
    ]
  end

  def neighbors_for_tile(tile)
    row, column = @matrix.index(tile)
    self.neighbors_for_cell row, column
  end

  def take_thing(tile)
    tile.thing

  end

  def process_smells
  end

  # TODO: Rename iterate! to iterate (it is immutable, and therefore ! is
  # confusing

  def iterate_smells
    grid = self

    grid = self.class.new(grid.matrix.collect { |tile|
      tile.iterate! grid
    })

    grid
  end

  def iterate!
    grid = self

    grid = self.class.new(grid.matrix.collect { |tile|
      tile.process_moves grid
    })

    trid = self.class.new(grid.matrix.collect { |tile|
      tile.iterate! grid
    })

    grid
  end

  def ==(other)
    @matrix == other.matrix
  end
end

