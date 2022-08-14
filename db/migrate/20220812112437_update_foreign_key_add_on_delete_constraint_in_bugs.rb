class UpdateForeignKeyAddOnDeleteConstraintInBugs < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :bugs, :projects
    add_foreign_key :bugs, :projects, on_delete: :cascade
  end
end
