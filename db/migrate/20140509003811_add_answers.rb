class AddAnswers < ActiveRecord::Migration
  def change
 
    create_table :answers do |t|
      t.belongs_to :question
      t.string :content
      t.timestamps
    end
  end
end
