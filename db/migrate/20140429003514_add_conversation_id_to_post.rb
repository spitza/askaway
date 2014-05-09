class AddConversationIdToPost < ActiveRecord::Migration
  def change
    add_column :posts, :conversation_id, :integer
  end
end
