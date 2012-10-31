class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :tag
      t.references :expense
    end
    add_index :tags, :expense_id
  end
end
