# frozen_string_literal: true

class ChangeNullColumnInProjects < ActiveRecord::Migration[5.2]
  def change
    change_column_null :projects, :name, false
  end
end
