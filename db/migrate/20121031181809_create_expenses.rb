class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.float :price
      t.string :item
      t.text :description
      t.boolean :resolved
      t.references :user
    end
    add_index :expenses, :user_id
  end
end
