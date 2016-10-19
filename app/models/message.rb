class Message < ActiveRecord::Base
  belongs_to :user, inverse_of: :messages
  has_many :received_messages, inverse_of: :message

  validates :body, presence: true

  def send_message(user)
    logger.debug 'About to send message...'

    client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID_PRODUCTION'], ENV['TWILIO_AUTH_TOKEN_PRODUCTION']
    twilio_number = ENV['TWILIO_NUMBER']
    message = client.
      account.
      messages.
      create(
        to: user.profile.phone_number,
        from: twilio_number,
        body: "#{body} -Sent to you by #{user.profile.moniker} in #{user.profile.location}"
      )

    ReceivedMessage.create(user: user, message: self)
    logger.debug 'Message sent!'

    # in the procfile, it'll run rake jobs:work
  end
end
