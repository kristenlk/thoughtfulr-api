# require 'clockwork'
# include Clockwork

class Message < ActiveRecord::Base
  belongs_to :user, inverse_of: :messages
  has_many :received_messages, inverse_of: :message

    # checks if the user selected to be notified by phone or email. only run send_message if a user selected 'phone'. run different action if user selected 'email'.
  def msg_method
    if @current_user.profile.email_or_phone == 'phone'
      true
    else
      false
    end
  end

# where should this go?

  # increments received message count (will be listed on settings page and will be part of what dictates whether or not a user can receive a new message)
  def increased_rcvd_msg_count
    @current_user.profile.number_of_received_messages += 1
  end



  # Find Message where the user_id of the person who sent it is NOT the current user. In ReceivedMessage, if the message_id of the selected Message is equal to the current_user, next.

  # def find_random_msg
  #   random_msg = Message.order('RANDOM()').first#.body
  #   # next if the message selected was sent by the current user
  #   next if random_msg.user_id == @current_user.id
  #   # next if the user has already received the message
  #   next if ReceivedMessage.where(user_id: @current_user.id)
  # end

  # Message.where.not(user_id: current_user)
    # use conditions like this -- find(:first, :conditions => { :user_id => user_name, :password => password })

  # counter = Message.where("column_name = ?", true).count
  # Message.where("column_name = ?", true).limit("#{rand(counter)}, 1").first


# SendMessageJob = Struct.new(:text, :emails) do
#   def perform
#     message = Message.find(5)
#     message.deliver
#   end
# end


  def when_to_send
    if User.find(1).profile.selected_time == 'morning'
      '18:02'
    elsif User.find(1).profile.selected_time == 'afternoon'
      '17:58'
    else
      '17:59'
    end
  end



  def send_message

    logger.debug 'About to send message...'

    # every(1.day, 'Queueing scheduled message', :at => when_to_send) { Delayed::Job.enqueue SendMessageJob.new }
    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID_PRODUCTION'], ENV['TWILIO_AUTH_TOKEN_PRODUCTION']

    @twilio_number = ENV['TWILIO_NUMBER']

    body = self.body

    @message = @client.account.messages.create({ :to => '+12039066039',
                                                 :from => @twilio_number,
                                                 :body => body })

    logger.debug 'Message sent!'
    # rcvd_message = ReceivedMessage.new(user_id: @current_user.id, message_id: Message.find(5).id)

  end

  # handle_asynchronously :send_message, :run_at => Proc.new { 5.minutes.from_now }, queue: 'Messages'

  handle_asynchronously :send_message, run_at: Proc.new { |i| i.when_to_send }
  #   if rcvd_message.save
  #     render json: rcvd_message


# Something like this to add stuff to the ReceivedMessages table:   foursquare.checkins.delay({:run_at => @time.minutes.from_now}).add(:venueId => @venue_id, :broadcast => "private")


  #     # increment sent_message count in Profiles table by 1
  #     # save message_id and user_id to ReceivedMessages table
  #   else
  #     render json: rcvd_message.errors, status: :unprocessable_entity
  #   end
  # end
  # end






# 4. put this method in ReceivedMessage model. 'create' method should be in this controller, and should run the send_message method I enter in ReceivedMessage model.

# 5. need to find the phone number and other various preferences of the user I'm sending a message to. Can't use current_user because message sending will be handled by a job handler, and the user probably won't be logged in when that job handler runs.
  # current_user_phone = current_user.profile.phone_number

# 6. How do I figure out the status of a sent message? Do I even need one, or should I just add it to the db once I send it?

# 7. If profile.number_of_sent_messages > user.received_messages, send out daily message. Elsif user.sent_messages <= user.received_messages, do not send out daily message.
#Add the message to user.received messages.






end
