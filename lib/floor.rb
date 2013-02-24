require 'tile'

class Floor < Tile
  # Receiving tiles
  def process_moves(grid)
    tile = grid.neighbors_for_tile(self).find { |t| t && t.take_thing(self) }

    tile ||= self if ! self.thing_wants_to_move_to
    new_thing = tile.thing if tile

    new new_thing, self.smells
  end


  # Giving tiles
  def thing_wants_to_move_to
    if thing
      @_thing_wants_to_move_to ||= thing.move_to?(grid.neighbors_for_tile(self))
    end
  end

  def take_thing(other_tile)
    thing_wants_to_move_to == other_tile
  end


  # TODO: Rename iterate! to process_smells
  def iterate!(grid)
    new_smells = calculate_new_smells(grid)
    new(self.thing, new_smells)
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

