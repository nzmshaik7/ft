class TwilioController < ApplicationController
  
  require 'rails'
  require 'twilio-ruby'
  
 
  def voice
  	twiml = Twilio::TwiML::MessagingResponse.new do |r|
    		r.message(body: 'Ahoy! Thanks so much for your m.')
  	end
  end

  post '/twiml' do
  	# Start our TwiML response
  	Twilio::TwiML::VoiceResponse.new do |r|
    		# Use <Say> to give the caller some instructions
    		r.say('hello world!', voice: 'alice')
  		end.to_s
  end



  post '/sms' do
=begin
  	twiml = Twilio::TwiML::MessagingResponse.new do |resp|
    		media = 'https://farm8.staticflickr.com/7090/6941316406_80b4d6d50e_z_d.jpg'
    		resp.message body: 'The Robots are coming! Head for the hills!' do |_m|
      			resp.media media
    		end
  	end

  	content_type 'text/xml'
  	twiml.to_s
=end
	twiml = Twilio::TwiML::MessagingResponse.new do |r|
    		r.message(body: 'Ahoy! Thanks so much for your message.')
  	end

  twiml.to_s
  end

end