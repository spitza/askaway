class AddResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.belongs_to :query
      t.belongs_to :user
      t.string :content
      t.timestamps
    end
  end
end
