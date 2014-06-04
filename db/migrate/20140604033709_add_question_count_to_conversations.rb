class AddQuestionCountToConversations < ActiveRecord::Migration
  def change
    add_column :conversations, :questions_count, :integer, default: 0
  end
end
