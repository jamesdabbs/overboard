class Instructor < ActiveRecord::Base
  belongs_to :user
  belongs_to :active_course, class_name: "Course"

  validates :email, presence: true, uniqueness: true

  def self.choices
    all.map { |i| [i.name, i.id] }
  end
end
