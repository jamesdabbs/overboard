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

  def summary
    course.timeline.week(number).summary
  end

  def goals
    course.timeline.week(number).goals
  end

  %w( plans reflections ).each do |attr|
    define_method(   attr   ) {       get attr      }
    define_method("#{attr}=") { |val| set attr, val }
  end

  def project
    Project.new self
  end

  def get *keys
    course.get :weeks, number, *keys
  end
  def set *keys, val
    course.set :weeks, number, *keys, val
  end

  def save!
    course.save!
  end
end
