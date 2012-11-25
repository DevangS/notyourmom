class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.references :expense
      t.datetime :date

      t.timestamps
    end
    add_index :reminders, :expense_id
  end
end
