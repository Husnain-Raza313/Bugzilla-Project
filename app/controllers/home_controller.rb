# frozen_string_literal: true


class HomeController < ApplicationController
  def index
    if current_user.manager?
      redirect_to users_path
    elsif current_user.qa? || current_user.developer?
      redirect_to view_projects_path id: current_user.id
    end
  end
end
