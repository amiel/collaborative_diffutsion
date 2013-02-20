require 'grid'
require 'wall'
require 'floor'
# require 'things'
#

class GridBuilder
  def initialize(stream)
    @map = split(stream.each_line)
  end

  def split(enum)
    enum.map { |line|
      line.chomp.split(//)
    }
  end

  def grid
    @grid ||= Grid.new(Matrix[*parse])
  end

  def parse
    @map.map { |row|
      row.map { |character|
        case character
        when /\s/
          Floor.new
        else
          Wall.new
        end
      }
    }
  end
end
