class AddDeveloperIdToBugs < ActiveRecord::Migration[5.2]
  def change
    add_column :bugs, :developer_ids, :string, array: true, default: []
  end
end
