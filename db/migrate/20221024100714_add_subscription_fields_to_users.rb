class AddSubscriptionFieldsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :plan, :string
    add_column :users, :subscription_status, :string , default: "incomplete"
  end
end
