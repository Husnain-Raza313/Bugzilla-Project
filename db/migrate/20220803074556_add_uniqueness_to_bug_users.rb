class AddUniquenessToBugUsers < ActiveRecord::Migration[5.2]
  def change
    add_index :bug_users, %i[bug_id user_id], unique: true
  end
end
