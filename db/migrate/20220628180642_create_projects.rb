class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.integer :project_id, index: { unique: true, name: 'unique_project_ids' }

      t.timestamps
    end
  end
end
