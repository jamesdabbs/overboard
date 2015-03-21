class ProfilePolicy < ApplicationPolicy
  def show
    user == record
  end
end
