class AddBugPriceColumnToBugsTable < ActiveRecord::Migration[5.2]
      def up
        add_column :bugs, :bug_price, :decimal, null: false, default: 0
        execute "update bugs set bug_price = 300"
      end

      def down
        remove_column :bugs, :bug_price
      end
end
