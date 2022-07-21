# frozen_string_literal: true

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

  def show?
    user.manager?
  end

  def create?
    user.manager?
  end

  def destroy?
    user.manager?
  end

  def view_projects?
    user.qa? || user.developer?
  end
end
