# Represents an imported Teamwork journal entry
class Journal < ActiveRecord::Base
  belongs_to :author, class_name: "Employee"

  validates_presence_of :title, :body
end
