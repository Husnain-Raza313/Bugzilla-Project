class AddUserTypeToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :user_type, :integer, :presence => true
  end
end
