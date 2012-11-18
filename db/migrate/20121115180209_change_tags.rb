class DropTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
