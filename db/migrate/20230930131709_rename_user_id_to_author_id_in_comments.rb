class RenameUserIdToAuthorIdInComments < ActiveRecord::Migration[7.0]
    def up
      rename_column :comments, :user_id, :author_id
    end
  
    def down
      rename_column :comments, :author_id, :user_id
    end
end
