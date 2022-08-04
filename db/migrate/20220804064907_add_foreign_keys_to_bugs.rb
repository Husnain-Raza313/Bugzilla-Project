class AddForeignKeysToBugs < ActiveRecord::Migration[5.2]
  def change
    add_reference :bugs, :qa, foreign_key: { to_table: 'users' }
    add_reference :bugs, :developer, foreign_key: { to_table: 'users' }

  end
end
