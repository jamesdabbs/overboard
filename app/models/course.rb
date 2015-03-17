class Course < ActiveRecord::Base
  belongs_to :instructor
  belongs_to :topic
  belongs_to :campus
end
