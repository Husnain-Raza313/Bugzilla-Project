class CodePieceUserPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def assigned?
    user.developer?
  end
  def unassigned?
    user.developer?
  end

  def assign?
    user.developer?
  end
  def remove?
    user.qa?
  end
  def show?
    user.qa? || user.developer?
  end
end
