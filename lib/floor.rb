require 'tile'

class Floor < Tile
  def iterate!(grid)
    new(thing, grid.neighbors_for_tile(self).inject(Hash.new) { |smells, e|
      e.smells.each do |unit, smell|
        smells[unit] ||= 0
        smells[unit] += e.smell_for(unit).to_f / 4
      end if e

      smells[thing.class] = 1 if thing

      smells
    })
  end

  def char
    thing ? thing.char : ' '
  end
end

