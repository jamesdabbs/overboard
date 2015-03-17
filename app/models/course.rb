class Course < ActiveRecord::Base
  belongs_to :instructor
  belongs_to :topic
  belongs_to :campus

  has_many :weeks

  validates :start_on, presence: true, uniqueness: { scope: [:topic, :campus] }

  def populate!
    return if weeks.exists?

    1.upto(12) do |n|
      w = weeks.create! number: n
      Week.lecture_days.each do |name|
        w.days.create! name: name
      end
    end
  end
end
