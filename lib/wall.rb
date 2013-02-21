# encoding: utf-8

require 'tile'

class Wall < Tile
  def iterate!(grid)
    self
  end

  def char
    WallCharacter.new(self).to_s
  end

  def neighbors
    grid.neighbors_for_tile(self)
  end

  class WallCharacter
    WALL_CHARACTERS = %w[ ■ ╵ ╶ └ ╷ │ ┌ ├ ╸ ┘ ─ ┴ ┐ ┤ ┬ ┼ ].freeze

    def initialize(wall)
      @wall = wall
    end

    def index
      @index =  (top    ? 1 << 0 : 0) +
                (right  ? 1 << 1 : 0) +
                (bottom ? 1 << 2 : 0) +
                (left   ? 1 << 3 : 0)
    end

    def is_a_wall?(side)
      neighbors[side].is_a?(Wall)
    end

    def top
      is_a_wall? 0
    end

    def right
      is_a_wall? 1
    end

    def bottom
      is_a_wall? 2
    end

    def left
      is_a_wall? 3
    end

    def neighbors
      # TODO: Fix demeter's violation
      @_neighbors = @wall.neighbors
    end

    def to_s
      WALL_CHARACTERS[index]
    end

    def to_i
      index
    end
  end
end
