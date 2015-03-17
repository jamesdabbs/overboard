class Campus < ActiveRecord::Base
  validates :name, uniqueness: true
end
