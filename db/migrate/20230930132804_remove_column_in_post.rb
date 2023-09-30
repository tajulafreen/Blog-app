class RemoveColumnInPost < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :commentsCounter
    remove_column :posts, :likesCounter
  end
end
