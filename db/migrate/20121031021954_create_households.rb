class CreateHouseholds < ActiveRecord::Migration
  def change
    create_table :households do |t|
      t.string :grp_name
    end
  end
end
