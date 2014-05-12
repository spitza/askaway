class AddVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :question_id
      t.integer :value
      t.timestamps
    end
  end
end
