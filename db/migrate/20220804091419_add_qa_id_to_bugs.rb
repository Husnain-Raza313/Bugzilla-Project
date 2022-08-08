class AddQaIdToBugs < ActiveRecord::Migration[5.2]
  def change
    add_column :bugs, :qa_id, :integer
  end
end
