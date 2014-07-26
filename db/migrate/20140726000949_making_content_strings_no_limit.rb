class MakingContentStringsNoLimit < ActiveRecord::Migration
  def change
    change_column :conversations, :prompt, :text, :limit => nil
    change_column :questions, :content, :text, :limit => nil
    change_column :answers, :content, :text, :limit => nil
  end
end
