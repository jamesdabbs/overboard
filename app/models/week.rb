class Week < ActiveRecord::Base
  belongs_to :course

  has_many :days

  validates :number, presence: true, inclusion: 1..12

  def self.lecture_days
    Date::DAYNAMES[1..4]
  end

  def markdown field
    raw = send field
    GitHub::Markup.render('README.md', raw).html_safe if raw.present?
  end

  def day name
    @_days ||= days.map { |d| [d.name, d] }.to_h
    @_days[name]
  end
end
