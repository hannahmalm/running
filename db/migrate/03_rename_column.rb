class RenameColumn < ActiveRecord::Migration[4.2]
    def change
      rename_column :logs, :owner_id, :user_id
    end
  end