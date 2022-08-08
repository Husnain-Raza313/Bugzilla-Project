class RemoveQaUserIdFromBugs < ActiveRecord::Migration[5.2]
  def change
    remove_column :bugs, :qa_id
  end
end
