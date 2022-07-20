# frozen_string_literal: true

class AddNameToUserProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :user_projects, :name, :string
  end
end
