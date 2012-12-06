desc "Send reminder to user to pay their debts"
task :send_reminder => :environment do
	reminders = Reminder.all
	reminders.each do |r|
		if r.date == DateTime.parse(Date.today.to_s)
			r.send_mail()
		end
	end
end
