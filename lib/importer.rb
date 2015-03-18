class Importer
  def initialize course, notes_dir
    @course, @notes_dir = course, notes_dir
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
      { number: Integer(number), summary: summary, goals: lines.join("\n").strip }
    end
    t.save!

    course.update timeline: t
  end

  def split_header text
    return if text.empty?
    lines = text.lines
    [lines.shift.gsub(/^#*\s*/, ''), lines.join("\n").strip]
  end

  def import_week! n
    w = @course.week n
    w.plans       = read n, "prep"
    w.reflections = read n, "reflections"

    summary, description = split_header(read n, "project")
    w.project = summary

    w.days.each do |d|
      d.summary, d.description = split_header(read n, d.name)
    end
  end
end
