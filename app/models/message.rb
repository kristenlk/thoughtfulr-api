class Message < ActiveRecord::Base
  belongs_to :user, inverse_of: :messages
  has_many :received_messages, inverse_of: :message

  validates :body, presence: true

  def send_message(receiving_user)
    logger.debug "Sending message to user_id #{receiving_user.id}"

    client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID_PRODUCTION'], ENV['TWILIO_AUTH_TOKEN_PRODUCTION']
    twilio_number = ENV['TWILIO_NUMBER']
    byebug
    message = client.
      account.
      messages.
      create(
        to: receiving_user.profile.phone_number,
        from: twilio_number,
        body: "#{body} -Sent to you by #{user.profile.moniker} in #{user.profile.location}"
      )

    ReceivedMessage.create(user: user, message: self)
    logger.debug "Message to user_id #{receiving_user.id} sent!"
  end
end
