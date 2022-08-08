class DropBugUsersTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :bug_users
  end
end
