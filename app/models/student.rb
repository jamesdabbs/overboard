class Student < ActiveRecord::Base
  belongs_to :course

  validates :github_username, presence: true, uniqueness: { scope: :course }
end
