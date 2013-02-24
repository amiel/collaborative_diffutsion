require 'tile'

class Thing < Tile
end

class Dude < Thing
  def move_to?(tiles)
    false
  end

  def char
    '*'
  end
end


class Enemy < Thing
  def move_to?(tiles)
    tiles.compact.max_by { |t| t.smell_for(Dude) - t.smell_for(Enemy) }
  end

  def char
    '%'
  end
end
