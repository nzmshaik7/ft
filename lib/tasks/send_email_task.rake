#This is a new and rudimentary file trying to achieve scheduled email

task :send_email_task => :environment do
	SendEmailTask.perform_later
end