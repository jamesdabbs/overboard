class Instructor < ActiveRecord::Base
  belongs_to :user
  belongs_to :active_course, class_name: "Course"
end
