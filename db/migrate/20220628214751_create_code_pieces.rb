class CreateCodePieces < ActiveRecord::Migration[5.2]
  def change
    create_table :code_pieces do |t|
      t.string :title, unique: true, null: false, default: ""

      t.timestamps
    end
  end
end
