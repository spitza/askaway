class CreateInquiries < ActiveRecord::Migration
  def change
    create_table :inquiries do |t|
      t.text :content
      t.references :user, index: true

      t.timestamps
    end
    add_index :inquiries, [:user_id, :created_at]
  end
end
