# frozen_string_literal: true

class BugPolicy < ApplicationPolicy
  class Scope < Scope
  end

  def index?
    user.qa?
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
    (user.qa? && record.qa_id == user.id)
  end

  def show?
    user.qa? || user.developer?
  end
end
