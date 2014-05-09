class RenamingPostsToQuestions < ActiveRecord::Migration
  def change
    rename_table :posts, :questions
  end
end
