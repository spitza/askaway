class ChangingQueriestoBigInt < ActiveRecord::Migration
  def change
    change_column(:queries, :asker_id, :bigint)
    change_column(:queries, :askee_id, :bigint)
    change_column(:responses, :user_id, :bigint)
    change_column(:queries, :asker_id, :bigint)
    change_column(:users, :id, :bigint)
  end
end
