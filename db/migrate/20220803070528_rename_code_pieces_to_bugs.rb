class RenameCodePiecesToBugs < ActiveRecord::Migration[5.2]
    def change
      rename_table :code_pieces, :bugs
    end
end
