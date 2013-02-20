require 'tile'

class Dude < Tile
  def char
    '*'
  end
end


class Enemy < Tile
  def char
    '%'
  end
end
