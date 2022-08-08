# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show]

  def index
    @users = User.all
    authorize @users
  end

  def show
    @userprojects = User.find(params[:id]).projects
    authorize @user
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :id, :email, :user_type)
  end
end
