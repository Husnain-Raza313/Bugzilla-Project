# frozen_string_literal: true

class CodePieceUserPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def index?
    user.developer?
  end

  def show?
    user.developer?
  end

  def create?
    user.developer?
  end

  def destroy?
    user.qa? || user.developer?
  end
end
