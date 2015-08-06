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


####
  # send message prep: is A JOB itself
  # find all users who are opted in. for each user, *send message*. i have a job that runs that queues other jobs.


  # to do: replace with activerecord
  def self.send_todays_messages
    users = User.find_by_sql("
      SELECT u.id, p.email_or_phone, p.phone_number
      FROM users u
      INNER JOIN profiles p
         ON u.id = p.user_id
      WHERE
        (SELECT count(*)
         FROM received_messages r
         WHERE r.user_id = u.id)
        <
        (SELECT count(*)
         FROM messages m
         WHERE m.user_id = u.id)
        AND
         p.opted_in = 't'
      ")

    users.each do |user|
      if
    end

  end

# SELECT u.id, p.email_or_phone, p.phone_number FROM users u, profiles p INNER JOIN profiles p ON u.id = p.user_id WHERE (SELECT count(*) FROM received_messages r WHERE r.user_id = u.id) < (SELECT count(*) FROM messages m WHERE m.user_id = u.id) AND p.opted_in = 't'

####

####
  # dictates when to send the message
  def when_to_send
    if User.find(1).profile.selected_time == 'morning'
      '18:02'
    elsif User.find(1).profile.selected_time == 'afternoon'
      '17:58'
    else
      '17:59'
    end
  end
####


####
  # find random message: self.findRandomMessage
####


####
  # Only send message if user has sent more messages than they have received messages
  ######   these methods are instance methods, so I don't need to do @current_user.messages.count

  def sent_msg_count
    messages.count
  end

  def received_msg_count
    received_messages.count
  end

####
  # in activerecord: later on, look at memoizing the count of something. if you add something, ups the count, etc.
#######




  def send_message(user, message)

    logger.debug 'About to send message...'

    # every(1.day, 'Queueing scheduled message', :at => when_to_send) { Delayed::Job.enqueue SendMessageJob.new }
    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID_PRODUCTION'], ENV['TWILIO_AUTH_TOKEN_PRODUCTION']

    @twilio_number = ENV['TWILIO_NUMBER']

    body = self.body
    phone = user.profile.phone

    @message = @client.account.messages.create({ :to => phone,
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
