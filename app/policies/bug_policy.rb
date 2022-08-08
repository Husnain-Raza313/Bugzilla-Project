# frozen_string_literal: true

class BugPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def index?
    user.qa? || user.developer?
  end

  def edit?
    update?
  end

  def update?
    (user.qa? && record.qa_id == user.id) || (user.developer? && record.developer_ids.include?(user.id.to_s))
  end

  def new?
    create?
  end

  def create?
    user.qa?
  end

  def destroy?
    (user.qa? && record.qa_id == user.id) || (user.developer? && record.developer_ids.include?(user.id.to_s))
  end

  def show?
    user.qa? || user.developer?
  end

  def assigned?
    user.qa? || user.developer?
  end

  def dev_create?
    user.developer?
  end
end
