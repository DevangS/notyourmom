class AddHouseholdIdToExpense < ActiveRecord::Migration
  def change
    add_column :expenses, :household_id, :integer

  end
end
