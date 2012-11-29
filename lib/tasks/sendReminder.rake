desc "Send reminder to user to pay their debts"
task :send_reminder => :environment do
	reminders = Reminder.all
	reminders.each do |r|
		r.send_mail()
		end
	end
end
