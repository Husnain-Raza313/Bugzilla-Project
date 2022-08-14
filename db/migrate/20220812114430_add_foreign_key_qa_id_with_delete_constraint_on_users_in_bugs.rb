class AddForeignKeyQaIdWithDeleteConstraintOnUsersInBugs < ActiveRecord::Migration[5.2]
  def change
    add_reference :bugs, :qa, on_delete: :cascade, foreign_key: { to_table: 'users', on_delete: :cascade }
    # add_foreign_key :bugs, :qa, foreign_key: { to_table: 'users', on_delete: :cascade}
  end
end
