class ChangeUidTypeInConversations < ActiveRecord::Migration
  def change
    change_column :conversations, :uid, :varchar
  end
end
