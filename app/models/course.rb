class Course < ActiveRecord::Base
  belongs_to :instructor
  belongs_to :topic
  belongs_to :campus

  belongs_to :timeline

  has_many :students

  validates :start_on, presence: true, uniqueness: { scope: [:topic, :campus] }

  serialize :data, JSON

  after_initialize { self.data ||= {} }

  def data
    super.try :with_indifferent_access
  end

  def get *keys
    keys.reduce(data) { |h,k| h[k.to_s] }
  rescue NoMethodError => e
    nil
  end

  def set *keys, key, val
    d = data
    keys.reduce(d) do |h,k|
      h[k.to_s] ||= {}
      h[k.to_s]
    end[key.to_s] = val
    self.data = d
  end

  def week n
    Week.new self, Integer(n)
  end
  def weeks
    1.upto(12).map { |n| week n }
  end

  def filename
    # FIXME!
    "dc.rb"
  end

  def name
    "#{topic.title} / #{start_on.strftime '%b %y'}"
  end

  def import_students octoclient, team
    octoclient.team_members(team).map do |m|
      students.where(github_id: m.id).first_or_create! do |s|
        s.github_username = m.login
      end
    end
  end
end
