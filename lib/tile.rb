class Tile
  attr_reader :smells
  def initialize(smells = {})
    @smells = smells
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
    }.join(',')
  end

  def inspect
    "#{self.class}(#{inspect_smells})"
  end
end


