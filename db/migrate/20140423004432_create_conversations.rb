class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.integer :uid
      t.string :prompt

      t.timestamps
    end
  end
end
