class TextSendController < ApplicationController
  def index
    twilio_sid = "ACb25a2c1d9fe5db1c4da24286265bf0b3"
    twilio_token = "ade30064e177e5988a6e5b1583c45de7"
    twilio_phone_number = "4804282886"
	
  end

  def send_text_message
    number_to_send_to = params[:number_to_send_to]

    

    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
    @twilio_client.account.sms.messages.create(
      :from => "+1#{twilio_phone_number}",
      :to => number_to_send_to,
      :body => "This is an message. It gets sent to #{number_to_send_to}"
    )
  end



  def send_to_positive_flag_store



  end


  def send_to_negative_flag_store


  end
end