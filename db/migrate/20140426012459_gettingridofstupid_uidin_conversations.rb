class GettingridofstupidUidinConversations < ActiveRecord::Migration
  def change
    remove_column :conversations, :uid
  end
end
