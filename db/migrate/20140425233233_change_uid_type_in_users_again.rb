class ChangeUidTypeInUsersAgain < ActiveRecord::Migration
  def change
    change_column :users, :uid, :varchar
  end
end