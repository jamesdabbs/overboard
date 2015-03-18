class WeekPolicy < ApplicationPolicy
  def show?
    true
  end

  def update?
    user.instructs? record.course
  end
end
