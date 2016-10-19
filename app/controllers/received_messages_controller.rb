require 'twilio-ruby'

class ReceivedMessagesController < ApplicationController

# Save message_id and user_id of a sent message to received_messages

# does this work? What do I need to put in message model to create a received message when a message is sent?
  # def create
  #   received_message = ReceivedMessage.new(received_message_params)

  #   if received_message.save
  #     render json: received_message
  #   else
  #     render json: { error: "Received message could not be created." }, status: 422
  #   end
  # end


  def received_message_params
    params.require(:received_messages).permit(:user_id, :message_id)
  end


end
