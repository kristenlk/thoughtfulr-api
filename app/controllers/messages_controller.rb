class MessagesController < ApplicationController

  # attr_reader :@client

  def initialize
  end

  # send a message


# create a message
  def create
    message = current_user.messages.build(message_params)
    if message.save
      render json: message
      # increment sent_message count in Profiles table by 1
    else
      render json: message.errors, status: :unprocessable_entity
    end
  end

# delete a message you've sent
  def delete

  end

# show all sent messages
  def list

  end

# edit a message you've sent
  def edit

  end

# show all received messages

  def received_messages
    render json: current_user.received_message_bodies
  end

# show all sent messages
  def sent_messages
    render json: current_user.messages
  end



  def message_params
    params.require(:message).permit(:body)
  end

end

# rails puts anything after the question mark in the URL and anything in the request body and any place you put in show/[:id] all end up in the params hash - to be used in my actions

# current_user comes out of the headers via the token - not part of the params hash
