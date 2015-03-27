class Locator
  def initialize klass
    @klass   = klass
    @objects = klass.all.map { |o| [o, o.names.map(&:downcase)] }.to_h
  end

  def locations str
    haystack = str.downcase
    @objects.select { |o,names| names.any? { |name| haystack.include?(name) } }.keys
  end

  def locate! str
    ls = locations str
    raise "Found #{ls.count} possible matches for '#{str}'" unless ls.count == 1
    ls.first
  end

  def locate str
    locate! str
  rescue
    nil
  end
end
