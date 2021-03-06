class Campus < ActiveRecord::Base
  validates :name, uniqueness: true

  def self.choices
    all.map { |c| [c.name, c.id] }
  end

  def names
    [name] + (aliases || [])
  end
end
