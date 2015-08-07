require 'twilio-ruby'

class ReceivedMessagesController < ApplicationController

# Save message_id and user_id of a sent message to received_messages
  def create
  end


  def received_message_params
    params.require(:received_messages).permit(:user_id, :message_id)
  end


end
