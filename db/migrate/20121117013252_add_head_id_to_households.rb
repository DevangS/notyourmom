class AddHeadIdToHouseholds < ActiveRecord::Migration
  def change
    add_column :households, :head_id, :integer

  end
end
