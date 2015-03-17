class Topic < ActiveRecord::Base
  validates :title, uniqueness: true
end
