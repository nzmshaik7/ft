class StoreFlagMailer < ActionMailer::Base
  default from: 'admin@ultimateequityholdings.com'

  def send_text

  require 'twilio-ruby'
  @account_sid = "ACb25a2c1d9fe5db1c4da24286265bf0b3" # Your Account SID from www.twilio.com/console
  @auth_token = "ade30064e177e5988a6e5b1583c45de7"   # Your Auth Token from www.twilio.com/console

  end

  def send_text_store_profit_flag_positive(store, employee)
	send_text
	@client = Twilio::REST::Client.new @account_sid, @auth_token
	message = @client.messages.create(
    	body: "Hello " + @employee.first_name + ", This mail is from FutureTech. This is to inform you that Your store " + @store.name + " is below 50% of profit. What went wrong? Please provide us with details.",
    	to: @store.phone,    # Replace with your phone number
    	from: "+14804282886")  # Replace with your Twilio number

	puts message.sid

  end


  def send_text_store_profit_flag_negative(store, employee)
	send_text
	@client = Twilio::REST::Client.new @account_sid, @auth_token
	message = @client.messages.create(
   	body: "Hello " + @employee.first_name + ", This mail is from FutureTech. Congratulations! Your store " + @store.name + " is in good standing.",
    	to: @store.phone,    # Replace with your phone number
    	from: "+14804282886")  # Replace with your Twilio number

	puts message.sid

  end

  
  

 
  def profit_flag_positive_email(s)
    send_mail(s)  
    send_text_store_profit_flag_positive(@store, @employee)
  end

  def profit_flag_negative_email(s)
    send_mail(s)
    send_text_store_profit_flag_negative(@store, @employee)
  end

  def proficiency_flag_positive_email(s)
    send_mail(s)
  end

  def proficiency_flag_negative_email(s)
    send_mail(s)
  end



  def send_mail(store)
	@store_info = store

   	@technician_details = StoreTechnicianDetails.all
    	@technician_array = Array.new
    	_k = -1
    	define_singleton_method(:k) do
  		_k += 1
    	end
    	@technician_details.each do|t|
		if t.store_id == @store_info[0]
			@technician_array[k] = t
		end
    	end   

	if @store_info[2] == 1
		@store_eff_flag = "Action needed. Value is:" + @store_info[3].round(3).to_s
    	else
		@store_eff_flag = "No action needed. Value is:" + @store_info[3].round(3).to_s
    	end

   	if @store_info[4] == 1
		@store_prod_flag = "Action needed. Value is:" + @store_info[5].round(3).to_s
    	else
		@store_prod_flag = "No action needed. Value is:" + @store_info[5].round(3).to_s
    	end

   	if @store_info[6] == 1
		@store_prof_flag = "Action needed. Value is:" + @store_info[7].round(3).to_s
    	else
		@store_prof_flag = "No action needed. Value is:" + @store_info[7].round(3).to_s
    	end
    
        @store = Store.find(@store_info[0])
    	@manager = @store.manager_id
    	@employee = Employee.find(@manager)
    	#@url  = 'http://example.com/login'
    	mail(to: @employee.email, subject: "Hi #{@employee.first_name}, #{@employee.last_name}")

  end


end