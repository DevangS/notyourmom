class AddCreatedAtColumnToExpense < ActiveRecord::Migration
  def change
    add_column :expenses, :created_at, :datetime

  end
end
