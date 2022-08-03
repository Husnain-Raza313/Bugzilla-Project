class CreateBugs < ActiveRecord::Migration[5.2]
  def change
    create_table :bugs do |t|

      t.timestamps
    end
  end
end
