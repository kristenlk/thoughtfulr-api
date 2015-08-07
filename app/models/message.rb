class Message < ActiveRecord::Base
  belongs_to :user, inverse_of: :messages
  has_many :received_messages, inverse_of: :message

  # Find Message where the user_id of the person who sent it is NOT the current user. In ReceivedMessage, if the message_id of the selected Message is equal to the current_user, next.

  # should this be a class or instance method? where should this be called?
  # Message.find_random

  def self.find_random(user)
   messages = Message.find_by_sql("SELECT * FROM messages")

    # messages = Message.find_by_sql("SELECT *
    # FROM messages m
    # WHERE
    #   m.user_id != :user_id AND
    #   m.id NOT IN (SELECT r.message_id
    #                FROM received_messages r
    #                WHERE r.user_id = :user_id)", {:user_id => user.id})
    messages.sample
  end


# send_todays_messages queues jobs for the day. this will be run in a Ruby script.
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
      # byebug
      if user.profile.phone?
        random_msg = Message.find_random(user)
        random_msg.send_message(user)
        handle_asynchronously :send_message, run_at: Proc.new { 1.minutes.from_now }# Proc.new { |i| i.when_to_send(user) }
      # else
        #
      end
    end

  end


####
  # dictates when to send the message - called in handle_asynchronously
  def when_to_send(user)
    '24:00'
    # if user.profile.selected_time == 'morning'
    #   '13:00'
    # elsif user.profile.selected_time == 'afternoon'
    #   '18:30'
    # else
    #   '23:00'
    # end
  end
####


  def send_message(user)
    logger.debug 'About to send message...'

    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID_PRODUCTION'], ENV['TWILIO_AUTH_TOKEN_PRODUCTION']

    @twilio_number = ENV['TWILIO_NUMBER']

    @message = @client.account.messages.create({ :to =>  5087454468, #user.profile.phone_number,
                                                 :from => @twilio_number,
                                                 :body => self.body })


    logger.debug 'Message sent!'

  end

  # handle_asynchronously :send_message, :run_at => Proc.new { 5.minutes.from_now }, queue: 'Messages'



# Something like this to add stuff to the ReceivedMessages table:   foursquare.checkins.delay({:run_at => @time.minutes.from_now}).add(:venueId => @venue_id, :broadcast => "private")



end
