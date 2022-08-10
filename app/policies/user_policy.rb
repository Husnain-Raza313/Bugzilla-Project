# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  class Scope < Scope
  end

  def index?
    user.manager?
  end

  def show?
    user.manager?
  end
end
