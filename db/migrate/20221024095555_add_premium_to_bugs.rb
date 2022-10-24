class AddPremiumToBugs < ActiveRecord::Migration[5.2]
  def change
    add_column :bugs, :premium, :string, null: false, default: "false"
  end
end
