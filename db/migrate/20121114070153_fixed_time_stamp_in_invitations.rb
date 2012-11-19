class FixedTimeStampInInvitations < ActiveRecord::Migration
  def up
  	change_column :invitations, :set_at, :timestamp, :null => false
  end

  def down
  end
end
