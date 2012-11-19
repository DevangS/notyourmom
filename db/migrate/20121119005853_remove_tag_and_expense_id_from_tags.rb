class RemoveTagAndExpenseIdFromTags < ActiveRecord::Migration
  def up
    remove_column :tags, :tag
        remove_column :tags, :expense_id
      end

  def down
    add_column :tags, :expense_id, :integer
    add_column :tags, :tag, :string
  end
end
