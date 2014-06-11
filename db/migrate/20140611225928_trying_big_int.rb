class TryingBigInt < ActiveRecord::Migration
  def change
    change_column(:users, :id, :bigint)
    change_column(:users, :uid, :bigint)
    change_column(:rs_evaluations, :source_id, :bigint)
    change_column(:questions, :user_id, :bigint)
    change_column(:conversations, :user_id, :bigint)
  end
end
