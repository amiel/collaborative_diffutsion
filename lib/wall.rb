# encoding: utf-8

require 'tile'

class Wall < Tile

  def char
    # WallCharacter.new(self).to_s
    '|'
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


    def to_s
      WALL_CHARACTERS[@value]
    end

    def to_i
      @value
    end
  end
end
