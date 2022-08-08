# frozen_string_literal: true

module Developer
  class BugPolicy < ApplicationPolicy
    class Scope < Scope
      # NOTE: Be explicit about which records you allow access to!
      # def resolve
      #   scope.all
      # end
    end

    def index?
      user.developer?
    end

    def new?
      user.developer?
    end

    def destroy?
      (user.developer? && record.developer_ids.include?(user.id.to_s))
    end

    def project_bugs?
      user.developer?
    end
  end
end
