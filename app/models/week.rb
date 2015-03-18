class Week
  def self.lecture_days
    Date::DAYNAMES[1..4]
  end

  attr_reader :course, :number

  def initialize course, number
    @course, @number = course, number
  end

  def day name
    Day.new self, name
  end
  def days
    Week.lecture_days.map { |name| day name }
  end

  %w( goals plans summary project ).each do |attr|
    define_method(   attr   ) {       get attr      }
    define_method("#{attr}=") { |val| set attr, val }
  end

  def get *keys
    course.get :weeks, number, *keys
  end
  def set *keys, key, val
    course.set :weeks, number, *keys, key, val
  end
end
