class CustomerFlagMailer < ActionMailer::Base
  default from: 'admin@ultimateequityholdings.com'

   def send_email(vehicle)
	@vehicle_info = vehicle
	
	
	@vehicle_info.each do |v|
		@veh = Vehicle.find(@vehicle_info[0])
		@cust = @veh.customer_id
		@customer = Customer.find(@cust)
		mail(to: @customer.email, subject: 'Hi #{@customer.first_name}, #{@customer.last_name}')
        end

   end


   def profit_flag_positive_email(vehicle)
	send_email(vehicle)
   end


   def profit_flag_negative_email(vehicle)
	send_email(vehicle)
   end

  def mileage_flag_positive_email(vehicle)
	send_email(vehicle)
  end


  def mileage_flag_negative_email(vehicle)
	send_email(vehicle)
  end






end
