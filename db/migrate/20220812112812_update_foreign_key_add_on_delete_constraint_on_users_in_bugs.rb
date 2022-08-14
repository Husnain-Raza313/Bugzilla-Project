class UpdateForeignKeyAddOnDeleteConstraintOnUsersInBugs < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :bugs, :users
  end
end
