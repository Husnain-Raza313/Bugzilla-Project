# frozen_string_literal: true

class CodePiecePolicy < ApplicationPolicy
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
    user.qa? || user.developer?
  end

  def new?
    create?
  end

  def create?
    user.qa?
  end

  def destroy?
    user.qa?
  end

  def show?
    user.qa? || user.developer?
  end

  def assigned?
    user.qa? || user.developer?
  end
end
