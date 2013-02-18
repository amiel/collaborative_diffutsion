require 'tile'

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
