class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
      t.text :content
      t.integer :asker_id
      t.integer :askee_id

      t.timestamps
    end
  end
end
