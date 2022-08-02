# frozen_string_literal: true

class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def index?
    user.manager? || user.qa?
  end

  def edit?
    update?
  end

  def update?
    user.manager? && record.user_id == user.id
  end

  def new?
    create?
  end

  def create?
    user.manager?
  end

  def show?
    user.manager? && record.user_id == user.id
  end

  def destroy?
    user.manager? && record.user_id == user.id
  end
end
