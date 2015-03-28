class Importer
  def initialize notes_dir
    @notes_dir = notes_dir

    dc    = Campus.where(name: "Washington, D.C.").first!
    ruby  = Topic.where(title: "Rails Engineering").first!
    james = Employee.where(email: "james@theironyard.com").first!

    @course = Course.where(
      campus: dc,
      topic: ruby,
      instructor: james,
      start_on: Date.parse("Jan 26, 2015")
    ).first_or_create!
  end

  def import!
    import_timeline!
    1.upto(12).each { |n| import_week! n }
    @course.save!
  end

private

  def course;    @course;    end
  def notes_dir; @notes_dir; end

  def read week, name
    path = File.join notes_dir, week.to_s.rjust(2, "0"), "#{name}.md"
    return unless File.exists? path
    body = File.read path
  end

  def import_timeline!
    body = File.read File.join(notes_dir, "timeline.md")
    description, *weeks = body.split('## ')
    raise "Expected 13 parts" unless weeks.count == 12
    t = Timeline.where(title: "Where We're Going, We Don't Need Rails").first_or_initialize
    t.description = description
    t.goals = weeks.map do |w|
      lines = w.lines
      _, number, summary = lines.shift.match(/Week (\d+) - (.*)/).to_a
      { number: Integer(number), summary: summary, goals: lines.join.strip }
    end
    t.save!

    course.update timeline: t
  end

  def split_header text
    return if text.empty?
    lines = text.lines
    [lines.shift.gsub(/^#*\s*/, ''), lines.join.strip]
  end

  def import_week! n
    w = @course.week n
    w.plans       = read n, "prep"
    w.reflections = read n, "reflections"

    w.project.summary, w.project.description = split_header(read n, "project")

    w.days.each do |d|
      d.summary, d.description = split_header(read n, d.name)
    end
  end
end
