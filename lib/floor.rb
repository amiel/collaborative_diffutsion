require 'tile'

class Floor < Tile
  def process_moves(grid)

  end

  # TODO: Rename iterate! to process_smells
  def iterate!(grid)
    new_smells = calculate_new_smells(grid)
    new(thing, new_smells)
  end

  def char
    thing ? thing.char : ' '
  end

  private
  def calculate_new_smells(grid)
    grid.neighbors_for_tile(self).inject(Hash.new) { |smells, e|
      e.smells.each do |unit, smell|
        smells[unit] ||= 0
        smells[unit] += e.smell_for(unit).to_f / 4
      end if e

      smells[thing.class] = 1 if thing

      smells
    }
  end
end

