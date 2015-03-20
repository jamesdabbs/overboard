class Project
  attr_reader :week, :summary, :description

  def initialize week
    @week = week
  end

  %w( summary description ).each do |attr|
    define_method(   attr   ) {       get attr      }
    define_method("#{attr}=") { |val| set attr, val }
  end

  def get *keys
    week.get :project, *keys
  end
  def set *keys, val
    week.set :project, *keys, val
  end
end
