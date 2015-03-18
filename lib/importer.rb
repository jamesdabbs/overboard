class Importer
  def initialize course, notes_dir
    @course, @notes_dir = course, notes_dir
  end

  def import!
    1.upto(12).each { |n| import_week! n }
  end

private

  def notes_dir
    @notes_dir
  end

  def read week, name
    path = File.join notes_dir, week.to_s.rjust(2, "0"), "#{name}.md"
    File.read path
  end

  def import_week! n
    w = @course.weeks.where(number: n).first_or_initialize
    w.project = read n, "project"
    w.save!

    Week.lecture_days.each do |name|
      d = w.days.where(name: name).first_or_initialize
      d.description = read n, name
      d.save!
    end
  end
end
