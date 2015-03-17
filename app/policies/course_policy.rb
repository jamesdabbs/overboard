class CoursePolicy < ApplicationPolicy
  def create?
    user.admin?
  end
end
