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


class Tile
  attr_reader :smells
  def initialize(smells = {})
    @smells = smells
  end

  def self.tiny_inspect
    self.name.to_s[0]
  end

  def new(*_)
    self.class.new(*_)
  end

  def smell_for(unit)
    @smells.fetch(unit, 0)
  end

  def inspect_smells
    smells.map { |unit, amount|
      "#{unit.tiny_inspect}:#{amount}"
    }.join(',')
  end

  def inspect
    "#{self.class}(#{inspect_smells})"
  end
end

class Floor < Tile
  def iterate!(grid)
    new grid.neighbors_for_tile(self).inject(Hash.new) { |smells, e|
      e.smells.each do |unit, smell|
        smells[unit] ||= 0
        smells[unit] += e.smell_for(unit).to_f / 9
      end if e

      smells
    }
  end
end

class Dude < Tile
end

class Enemy < Tile
end
