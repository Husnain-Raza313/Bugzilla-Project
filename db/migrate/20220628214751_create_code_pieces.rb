class CreateCodePieces < ActiveRecord::Migration[5.2]
  def change
    create_table :code_pieces do |t|
      t.belongs_to :project, index: true, foreign_key: true
      t.timestamps
    end
  end
end
