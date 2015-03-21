require 'csv'

CSV.foreach File.expand_path("../courses.csv", __FILE__), headers: true do |course|
  campus = Campus.where(name: course["campus"]).first_or_create!
  topic  = Topic.where(title: course["topic"]).first_or_create!

  email = course["instructor_email"] + "@theironyard.com"
  instructor = Instructor.
    where(email: email).
    create_with(
      first_name: course["instructor_first_name"],
      last_name:  course["instructor_last_name"]
    ).
    first_or_create!

  start = course["start"] || Date.parse("Jan 5, 2015")
  course = Course.
    where(campus: campus, instructor: instructor, topic: topic).
    create_with(start_on: start).
    first_or_create!
end
