desc "Send reminder to user to pay their debts"
task :send_reminder => :environment do
	reminders = Reminder.all
	reminders.each do |r|
		expense = r.expense
		expense.debts.each do |d|
			mail = Mailer.reminder(d.user, d.get_share, expense)
			mail.deliver
		end
	end
end
