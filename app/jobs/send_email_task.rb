class SendEmailTask < ActiveJob::Base
	queue_as :default

	def perform()
		#@users = User.all

		@store_flags = ActiveRecord::Base.connection.execute("call store_flags()")
		ActiveRecord::Base.clear_active_connections!

		define_singleton_method(:i) do
  			_i += 1
		end

		@store_flags.each do |f|
			if f[1] == 1
				StoreFlagMailer.profit_flag_positive_email(f).deliver_later
			else
				StoreFlagMailer.profit_flag_negative_email(f).deliver_later
			end	

			if f[5] == 1
				StoreFlagMailer.proficiency_flag_positive_email(f).deliver_later
			else
				StoreFlagMailer.proficiency_flag_negative_email(f).deliver_later
			end		
		end


=begin
                @vehicle_flags = ActiveRecord::Base.connection.execute("call vehicle_flags()")
		ActiveRecord::Base.clear_active_connections!


		@vehicle_flags.each do |v|
			if v[1] == 1
				CustomerFlagMailer.profit_flag_positive_email(v).deliver_later
			else
				CustomerFlagMailer.profit_flag_negative_email(v).deliver_later
			end

			if v[2] == 1
				CustomerFlagMailer.mileage_flag_positive_email(v).deliver_later
			else
				CustomerFlagMailer.mileage_flag_negative_email(v).deliver_later
			end

		end
=end

	end
	#handle_asynchronously :perform


        
	

end