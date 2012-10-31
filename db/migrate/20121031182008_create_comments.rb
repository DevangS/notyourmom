class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :comment
      t.references :expense
      t.references :user
    end
    add_index :comments, :expense_id
    add_index :comments, :user_id
  end
end
