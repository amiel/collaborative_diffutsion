class Tile
  attr_reader :thing, :smells

  # TODO: This is not immutable, which was one of my design goals
  attr_accessor :grid

  def initialize(thing = nil, smells = {})
    @thing, @smells = thing, smells
  end

  def self.tiny_inspect
    self.name.to_s[0]
  end

  def new(*_)
    self.class.new(*_)
  end

  def smell_for(unit)
    @smells.fetch(unit, 0)
  end

  def inspect_smells
    smells.map { |unit, amount|
      "#{unit.tiny_inspect}:#{amount}"
    }.join(',') if smells.any?
  end

  def inspect_thing
    thing.class.tiny_inspect if thing
  end

  def inspect
    args = [
      inspect_thing,
      inspect_smells,
    ].compact.join(',')
    "#{self.class}(#{args})"
  end

  # This is not good, it screws up @matrix.index (used in Grid)
  # def ==(other)
  #   self.inspect == other.inspect
  # end
end

