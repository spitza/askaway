class AddBannerurlToUsers < ActiveRecord::Migration
  def change
    add_column :users, :bannerurl, :string
  end
end
