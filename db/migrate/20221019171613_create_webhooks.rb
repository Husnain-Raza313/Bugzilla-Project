class CreateWebhooks < ActiveRecord::Migration[5.2]
  def change
    create_table :webhooks do |t|
      t.string :source
      t.string :external_id
      t.json :data
      t.integer :state, default: 0
      t.text :processing_errors

      t.timestamps
    end
    add_index :webhooks, :source
    add_index :webhooks, :external_id
    add_index :webhooks, [:source, :external_id]
  end
end
