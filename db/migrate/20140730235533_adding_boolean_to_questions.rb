class AddingBooleanToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :has_answer, :boolean, default: false
  end
end
