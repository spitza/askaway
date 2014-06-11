class Changeuseridtobigint < ActiveRecord::Migration
  def change
    change_column(:users, :id, :integer, :limit => 8)
    change_column(:users, :uid, :integer, :limit => 8)
    change_column(:rs_evaluations, :source_id, :integer, :limit => 8)
    change_column(:questions, :user_id, :integer, :limit => 8)
    change_column(:conversations, :user_id, :integer, :limit => 8)
  end
end
