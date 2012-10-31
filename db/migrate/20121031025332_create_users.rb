class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstName
      t.string :lastName
      t.string :email
      t.string :password
      t.string :fb_key
      t.integer :household_id

      t.timestamps
    end
  end
end
