# frozen_string_literal: true

class CreateCodePieces < ActiveRecord::Migration[5.2]
  def change
    create_table :code_pieces do |t|
      t.belongs_to :project, index: true, foreign_key: true
      t.string :title, null: false, default: ''
      t.integer :piece_status, null: false, default: 0
      t.date :deadline
      t.text :description
      t.string :screenshot
      t.string :type
      t.timestamps
    end
  end
end
