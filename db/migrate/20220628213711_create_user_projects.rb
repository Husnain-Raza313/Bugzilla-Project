# frozen_string_literal: true

class CreateUserProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :user_projects do |t|
      # t.references :User
      # t.references :Project

      t.belongs_to :user
      t.belongs_to :project
      t.string :name

      t.timestamps
    end
  end
end
