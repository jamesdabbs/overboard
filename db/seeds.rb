require 'csv'

CSV.foreach File.expand_path("../courses.csv", __FILE__), headers: true do |course|
  campus     = Campus.where(name: course["campus"]).first_or_create!
  topic      = Topic.where(title: course["topic"]).first_or_create!
  instructor = Instructor.
    where(email: course["instructor_email"]).
    create_with(name: course["instructor_name"]).
    first_or_create!

  course = Course.
    where(campus: campus, instructor: instructor, topic: topic).
    create_with(start_on: course["start"]).
    first_or_create!
end
