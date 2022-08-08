class RemoveQaIdFromBugs < ActiveRecord::Migration[5.2]
  def change
    remove_reference :bugs, :user, index: true
  end
end
