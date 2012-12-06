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


# set up tanya as head
notyourmom.update_attributes(:head_id => tanya.id)


#Cleaning supplies 50, split evently, by tanya
cleaning_supp = Expense.create(
	:user_id => tanya.id, 
	:resolved => false,
	:item => 'cleaning supplies', 
	:price => 50.00, 
	:household_id => tanya.household_id,
	:description =>'Febreeze and stuff',
	:created_at => DateTime.parse(1.day.ago.to_s))
debt00 = Debt.create(
	:expense_id => cleaning_supp.id, 
	:user_id => devang.id,
	:percentage_owed =>20,
	:paid => false)
debt01 = Debt.create(
	:expense_id => cleaning_supp.id, 
	:user_id => scott.id,
	:percentage_owed =>20,
	:paid => false) 
debt02 = Debt.create(
	:expense_id => cleaning_supp.id, 
	:user_id => helen.id,
	:percentage_owed =>20,
	:paid => false) 
debt03 = Debt.create(
	:expense_id => cleaning_supp.id, 
	:user_id => bulat.id,
	:percentage_owed =>20,
	:paid => false) 

#Booze, $100 50% split with scott
booze = Expense.create(
	:user_id => tanya.id, 
	:resolved => false,
	:item => 'booze', 
	:price => 50.00, 
	:household_id => tanya.household_id,
	:description =>'Hennessy, Grey Goose, Patron, Midori',
	:created_at => DateTime.parse(1.day.ago.to_s))
debt10 = Debt.create(
	:expense_id => booze.id, 
	:user_id => devang.id,
	:percentage_owed =>50,
	:paid => false)

#weed
weed = Expense.create(
	:user_id => scott.id, 
	:resolved => false,
	:item => 'weed', 
	:price => 100.00, 
	:household_id => scott.household_id,
	:description =>'awww yeaah',
	:created_at => DateTime.parse(20.days.ago.to_s))
debt00 = Debt.create(
	:expense_id => weed.id, 
	:user_id => devang.id,
	:percentage_owed =>20,
	:paid => false)
debt01 = Debt.create(
	:expense_id => weed.id, 
	:user_id => tanya.id,
	:percentage_owed =>20,
	:paid => false) 
debt02 = Debt.create(
	:expense_id => weed.id, 
	:user_id => helen.id,
	:percentage_owed =>20,
	:paid => false) 
debt03 = Debt.create(
	:expense_id => weed.id, 
	:user_id => bulat.id,
	:percentage_owed =>20,
	:paid => false) 

#weed2 2 months ago
weed = Expense.create(
	:user_id => scott.id, 
	:resolved => true,
	:item => 'weed', 
	:price => 100.00, 
	:household_id => scott.household_id,
	:description =>'awww yeaah',
	:created_at => DateTime.parse(2.months.ago.to_s))
debt00 = Debt.create(
	:expense_id => weed.id, 
	:user_id => devang.id,
	:percentage_owed =>20,
	:paid => true)
debt01 = Debt.create(
	:expense_id => weed.id, 
	:user_id => tanya.id,
	:percentage_owed =>20,
	:paid => true) 
debt02 = Debt.create(
	:expense_id => weed.id, 
	:user_id => helen.id,
	:percentage_owed =>20,
	:paid => false) 
debt03 = Debt.create(
	:expense_id => weed.id, 
	:user_id => bulat.id,
	:percentage_owed =>20,
	:paid => true) 

#plates
exp = Expense.create(
	:user_id => helen.id, 
	:resolved => false,
	:item => 'paper plates', 
	:price => 10.00, 
	:household_id => helen.household.id,
	:description =>'for the party on friday',
	:created_at => DateTime.parse(2.months.ago.to_s))
debt00 = Debt.create(
	:expense_id => exp.id, 
	:user_id => devang.id,
	:percentage_owed =>20,
	:paid => true)
debt01 = Debt.create(
	:expense_id => exp.id, 
	:user_id => scott.id,
	:percentage_owed =>20,
	:paid => true) 
debt02 = Debt.create(
	:expense_id => exp.id, 
	:user_id => scott.id,
	:percentage_owed =>20,
	:paid => true) 
debt03 = Debt.create(
	:expense_id => exp.id, 
	:user_id => bulat.id,
	:percentage_owed =>20,
	:paid => true) 

#kitchen towels
exp = Expense.create(
	:user_id => helen.id, 
	:resolved => false,
	:item => 'kitchen towels', 
	:price => 15.00, 
	:household_id => helen.household.id,
	:description =>'so we don\'t waste paper towels',
	:created_at => DateTime.parse(5.days.ago.to_s))
debt00 = Debt.create(
	:expense_id => exp.id, 
	:user_id => devang.id,
	:percentage_owed =>20,
	:paid => true)
debt01 = Debt.create(
	:expense_id => exp.id, 
	:user_id => scott.id,
	:percentage_owed =>20,
	:paid => true) 
debt02 = Debt.create(
	:expense_id => exp.id, 
	:user_id => scott.id,
	:percentage_owed =>20,
	:paid => true) 
debt03 = Debt.create(
	:expense_id => exp.id, 
	:user_id => bulat.id,
	:percentage_owed =>20,
	:paid => false) 

#bread
exp = Expense.create(
	:user_id => helen.id, 
	:resolved => false,
	:item => 'bread for the house', 
	:price => 25.00, 
	:household_id => helen.household.id,
	:description =>'I prefer rice',
	:created_at => DateTime.parse(19.days.ago.to_s))
debt00 = Debt.create(
	:expense_id => exp.id, 
	:user_id => devang.id,
	:percentage_owed =>20,
	:paid => true)
debt01 = Debt.create(
	:expense_id => exp.id, 
	:user_id => scott.id,
	:percentage_owed =>20,
	:paid => true) 
debt02 = Debt.create(
	:expense_id => exp.id, 
	:user_id => scott.id,
	:percentage_owed =>20,
	:paid => false) 
debt03 = Debt.create(
	:expense_id => exp.id, 
	:user_id => bulat.id,
	:percentage_owed =>20,
	:paid => true) 
