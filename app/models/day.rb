class Day
  attr_reader :week, :name

  def initialize week, name
    @week, @name = week, name
  end

  %w( summary description ).each do |attr|
    define_method(   attr   ) {       get attr      }
    define_method("#{attr}=") { |val| set attr, val }
  end

  def get *keys
    week.get name, *keys
  end
  def set *keys, val
    week.set name, *keys, val
  end
end
