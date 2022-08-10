# frozen_string_literal: true

class UserProjectPolicy < ApplicationPolicy
  class Scope < Scope
  end

  def index?
    user.manager?
  end

  def show?
    user.manager?
  end

  def create?
    user.manager? && record.manager_id == user.id
  end

  def destroy?
    user.manager? && record.manager_id == user.id
  end

  def view_projects?
    user.qa? || user.developer?
  end
end
