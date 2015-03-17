class Course < ActiveRecord::Base
  belongs_to :instructor
  belongs_to :topic
  belongs_to :campus

  validates :start_on, presence: true, uniqueness: { scope: [:topic, :campus] }
end
