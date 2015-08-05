require 'twilio-ruby'

class ReceivedMessagesController < ApplicationController


## 1. IMPLEMENT AFTER MESSAGES ARE SENDING ##
  # checks if the user selected to be notified by phone or email. only run send_message if a user selected 'phone'. run different action if user selected 'email'.
  # if current_user.profile.phone_or_email == 'phone'

  # def msg_method
  #   if current_user.profile.phone_or_email == 'phone'
  #     true
  #   else
  #     false
  # end

## 2. IMPLEMENT AFTER MESSAGES ARE SENDING ##
  # def increased_rcvd_msg_count
  #   current_user.profile.number_of_received_messages += 1
  # end

## 3. IMPLEMENT AFTER MESSAGES ARE SENDING ##
  # Find Message where the user_id of the person who sent it is NOT the current user. In ReceivedMessage, if the message_id of the selected Message is equal to the current_user, next.
  # msg_body = Message.order('RANDOM()').body

  # Message.where.not(user_id: current_user)
    # use conditions like this -- find(:first, :conditions => { :user_id => user_name, :password => password })

  # counter = Message.where("column_name = ?", true).count
  # Message.where("column_name = ?", true).limit("#{rand(counter)}, 1").first


# 4. put this method in ReceivedMessage model. 'create' method should be in this controller, and should run the send_message method I enter in ReceivedMessage model.

# 5. need to find the phone number and other various preferences of the user I'm sending a message to. Can't use current_user because message sending will be handled by a job handler, and the user probably won't be logged in when that job handler runs.
  # current_user_phone = current_user.profile.phone_number

# 6. How do I figure out the status of a sent message? Do I even need one, or should I just add it to the db once I send it?

# 7. If profile.number_of_sent_messages > user.received_messages, send out daily message. Elsif user.sent_messages <= user.received_messages, do not send out daily message.
#Add the message to user.received messages.


  def create #send_message
    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID_PRODUCTION'], ENV['TWILIO_AUTH_TOKEN_PRODUCTION']
    @twilio_number = ENV['TWILIO_NUMBER']
    body = Message.find(5).body
    @message = @client.account.messages.create({ :to => '+12039066039',
                                                 :from => @twilio_number,
                                                 :body => body })
    ReceivedMessage.new(user_id: @current_user.user_id, message_id: body)
  end






# list all the messages you've received
def list

end




end
