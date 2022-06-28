class CreateUserProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :user_projects do |t|
      t.references :User, foreign_key: true
      t.references :Project, foreign_key: true

      t.timestamps
    end
  end
end
