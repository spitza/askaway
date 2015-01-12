class AddBooleantoQuery < ActiveRecord::Migration
  def change
    add_column :queries, :has_response, :boolean, default: false
  end
end
