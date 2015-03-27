class Employee < ActiveRecord::Base
  belongs_to :user
  has_many :journals, foreign_key: :author_id

  validates :email, presence: true, uniqueness: true

  def self.choices
    all.map { |i| [i.name, i.id] }
  end

  def name
    "#{first_name} #{last_name}".strip
  end
end
