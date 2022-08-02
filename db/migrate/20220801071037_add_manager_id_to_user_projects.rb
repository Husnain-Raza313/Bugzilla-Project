class AddManagerIdToUserProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :user_projects, :manager_id, :integer
  end
end
