# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Household.delete_all
User.delete_all
Authentication.delete_all
# set up notyoumom household
notyourmom = Household.create(:name => 'NotYourMom')

# set up members
devang = User.create(:firstName => :devang, :lastName => :sampat, 
	:email => 'ds@doodle.com', :household_id => notyourmom.id, 
	:password => "password", :password_confirmation => "password")
theresa = User.create(:firstName => :theresa, :lastName => :calderon, 
	:email => 'tc@doodle.com', :household_id => notyourmom.id, 
	:password => "password", :password_confirmation => "password")
helen = User.create(:firstName => :helen, :lastName => :peng, 
	:email =>'hp@doodle.com', :household_id => notyourmom.id, 
	:password => "password", :password_confirmation => "password")
jenny = User.create(:firstName => :jenny, :lastName => :huang, 
	:email =>'jh@doodle.com', :household_id => notyourmom.id, 
	:password => "password", :password_confirmation => "password")
bulat = User.create(:firstName => :bulat, :lastName => :bochkariov, 
	:email => 'bb@doodle.com', :household_id => notyourmom.id, 
	:password => "password", :password_confirmation => "password")
tanya = User.create(:firstName => :tanya, :lastName => :chibisova, 
	:email=>'tch@doodle.com', :household_id=> notyourmom.id, 
	:password => "password", :password_confirmation => "password")

# set up tanya as head
notyourmom.update_attributes(:head_id => tanya.id)
