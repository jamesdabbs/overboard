class Topic < ActiveRecord::Base
  validates :title, uniqueness: true

  def self.choices
    all.map { |t| [t.title, t.id] }
  end
end
