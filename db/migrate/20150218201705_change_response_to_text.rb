class ChangeResponseToText < ActiveRecord::Migration
  def change
    change_column(:responses, :content, :text)
  end
end
