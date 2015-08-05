require 'twilio-ruby'

class ReceivedMessagesController < ApplicationController


  # def create #send_message
  #   @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID_PRODUCTION'], ENV['TWILIO_AUTH_TOKEN_PRODUCTION']
  #   @twilio_number = ENV['TWILIO_NUMBER']
  #   body = Message.find(5).body
  #   @message = @client.account.messages.create({ :to => '+12039066039',
  #                                                :from => @twilio_number,
  #                                                :body => body })
  #   # byebug
  #   rcvd_message = ReceivedMessage.new(user_id: @current_user.id, message_id: Message.find(5).id)
  #   if rcvd_message.save
  #     render json: rcvd_message
  #     # increment sent_message count in Profiles table by 1
  #   else
  #     render json: rcvd_message.errors, status: :unprocessable_entity
  #   end
  # end



# list all the messages you've received
def list

end




end
