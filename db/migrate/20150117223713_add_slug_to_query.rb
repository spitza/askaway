class AddSlugToQuery < ActiveRecord::Migration
  def change
    add_column :queries, :slug, :string
    add_index :queries, :slug, :unique => true
  end
end
