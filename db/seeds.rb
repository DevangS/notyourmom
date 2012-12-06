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
Debt.delete_all
Reminder.delete_all
Invitation.delete_all
Comment.delete_all
Expense.delete_all
Tag.delete_all

# set up notyoumom household
notyourmom = Household.create(:name => 'NotYourMom')

# set up members
devang = User.create(:firstName => :devang, :lastName => :sampat, 
	:email => 'ds@doodle.com', :household_id => notyourmom.id, 
	:password => "password", :password_confirmation => "password")
#theresa = User.create(:firstName => :theresa, :lastName => :calderon, 
#	:email => 'tc@doodle.com', :household_id => notyourmom.id, 
#	:password => "password", :password_confirmation => "password")
helen = User.create(:firstName => :helen, :lastName => :peng, 
	:email =>'hp@doodle.com', :household_id => notyourmom.id, 
	:password => "password", :password_confirmation => "password")
#jenny = User.create(:firstName => :jenny, :lastName => :huang, 
#	:email =>'jh@doodle.com', :household_id => notyourmom.id, 
#	:password => "password", :password_confirmation => "password")
bulat = User.create(:firstName => :bulat, :lastName => :bochkariov, 
	:email => 'bb@doodle.com', :household_id => notyourmom.id, 
	:password => "password", :password_confirmation => "password")
tanya = User.create(:firstName => :tanya, :lastName => :chibisova, 
	:email=>'tch@doodle.com', :household_id=> notyourmom.id, 
	:password => "password", :password_confirmation => "password")
scott = User.create(:firstName => :scott, :lastName => :ngo, 
	:email =>'sn@doodle.com', :household_id => notyourmom.id, 
	:password => "password", :password_confirmation => "password")

#Cleaning supplies 50, split evently, by tanya
cleaning_supp = Expense.create(
	:user_id => tanya.id, 
	:resolved => false,
	:item => 'cleaning supplies', 
	:price => 50.00, 
	:household_id => tanya.household_id,
	:description =>'Febreeze and stuff',
	:created_at => "2012-12-01 04:49:46.926786")
debt00 = Debt.create(
	:expense_id => cleaning_supp.id, 
	:user_id => devang.id,
	:percentage_owed =>10,
	:paid => false,)
debt01 = Debt.create(
	:expense_id => cleaning_supp.id, 
	:user_id => scott.id,
	:percentage_owed =>10,
	:paid => false,) 
debt02 = Debt.create(
	:expense_id => cleaning_supp.id, 
	:user_id => helen.id,
	:percentage_owed =>10,
	:paid => false,) 
debt01 = Debt.create(
	:expense_id => cleaning_supp.id, 
	:user_id => bulat.id,
	:percentage_owed =>10,
	:paid => false,) 

#Booze, $100 50% split with scott
booze = Expense.create(
	:user_id => tanya.id, 
	:resolved => false,
	:item => 'booze', 
	:price => 50.00, 
	:household_id => tanya.household_id,
	:description =>'Hennessy, Grey Goose, Patron, Midori',
	:created_at => "2012-12-02 04:49:46.926786")
debt10 = Debt.create(
	:expense_id => booze.id, 
	:user_id => devang.id,
	:percentage_owed =>50,
	:paid => false,)




# set up tanya as head
notyourmom.update_attributes(:head_id => tanya.id)
