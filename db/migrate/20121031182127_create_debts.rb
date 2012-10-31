class CreateDebts < ActiveRecord::Migration
  def change
    create_table :debts do |t|
      t.float :percentage_owed
      t.boolean :paid
      t.references :user
      t.references :expense
    end
    add_index :debts, :user_id
    add_index :debts, :expense_id
  end
end
