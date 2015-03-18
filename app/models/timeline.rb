require 'ostruct'

class Timeline < ActiveRecord::Base
  serialize :goals, JSON

  validates :title, presence: true, uniqueness: true

  def week n
    OpenStruct.new goals.find { |g| g["number"] == n }
  end
end
