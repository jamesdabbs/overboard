class CoursePolicy < ApplicationPolicy
  def create?
    user.admin?
  end

  def update?
    user.admin? || user.instructs?(record)
  end
end
