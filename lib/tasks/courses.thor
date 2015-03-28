require 'thor/rails'

class Courses < Thor
  include Thor::Rails

  desc 'generate', 'randomly generate course data'
  def generate
    require 'faker'

    c = Course.new(
      topic:      Topic.all.sample,
      campus:     Campus.all.sample,
      instructor: Instructor.all.sample,
      start_on:   Date.today + rand(-2..2).weeks + rand(-3..3).days
    )
    c.weeks.each do |w|
      w.summary = Faker::Company.catch_phrase
      w.goals   = rand(2..3).times.map { "* #{Faker::Company.bs}" }.join "\n"
      w.plans   = Faker::Lorem.paragraph
      w.project = Faker::Hacker.say_something_smart
      w.days.each do |d|
        d.description = Faker::Lorem.paragraphs(2).join "\n\n"
        d.summary = "#{Faker::Hacker.adjective} #{Faker::Hacker.noun}"
      end
    end
    c.save!
  end

  desc 'import', 'import course notes from a folder'
  def import path
    require ::Rails.root.join("lib", "importer")
    full_path = ::Rails.root.join(path)
    Importer.new(full_path).import!
  end
end
