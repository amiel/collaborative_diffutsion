require 'grid'

class GridPrinter
  def initialize(grid, stream = STDOUT, options = {})
    @grid, @stream = grid, stream
  end

  def write
    @grid.matrix.each_with_index do |tile, row, column|
      print_tile(tile)
      @stream << "\n" if column == @grid.matrix.column_size - 1
    end
  end

  def print_tile(tile)
    with_color(color_for_tile(tile)) do
      @stream << tile.char
    end
  end

  def with_color(color)
    Color256.set_color(nil, color) if color?
    yield
    Color256.reset_color if color?
  end

  def color?
    true
  end

  def color_value_for_smell(smell)
    val = Math.log(smell * 600)
    val = [0, [5, val].min].max
    val.to_i
  end

  def color_for_tile(tile)
    red = color_value_for_smell tile.smell_for(Dude)
    blue = color_value_for_smell tile.smell_for(Enemy)
    Color256.rgb(red, 0, blue)
  end



  module Color256
    module_function

    def rgb(red, green, blue)
      16 + (red * 36) + (green * 6) + blue
    end

    def gray(g)
      232 + g
    end

    def set_color(fg, bg)
      print "\x1b[38;5;#{fg}m" if fg
      print "\x1b[48;5;#{bg}m" if bg
    end

    def reset_color
      print "\x1b[0m"
    end

    def print_color(txt, fg, bg)
      set_color(fg, bg)
      print txt
      reset_color
    end
  end
end
