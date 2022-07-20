class UserProjectPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def index?
    user.manager?
  end

  def unassigned?
    user.manager?
  end

  def assign?
    user.manager?
  end
  def remove?
    user.manager?
  end
  def view_projects?
    user.qa? || user.developer?
  end

end
