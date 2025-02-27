# frozen_string_literal: true

module UserProjectsHelper
  def panel_heading(user)
    user.developer? ? "Developer's Panel" : "QA's Panel"
  end
end
