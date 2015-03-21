class StudentPolicy < ApplicationPolicy
  def create?
    user.instructs? record.course
  end
end
