class Reminder < ActiveRecord::Base
  belongs_to :expense

  validates_presence_of :date, :expense

  def send_mail()
  	#expense.send_reminders()
  end
end
