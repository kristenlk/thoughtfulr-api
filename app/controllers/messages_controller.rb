class MessagesController < ApplicationController

  def create
    message = current_user.messages.build(message_params)
    if message.save
      render json: message
      # increment sent_message count in Profiles table by 1
    else
      render json: message.errors, status: :unprocessable_entity
    end
  end

  def delete

  end


  def list

  end

  def edit

  end

  def message_params
    params.require(:message).permit(:body)
  end
end

# rails puts anything after the question mark in the URL and anything in the request body and any place you put in show/[:id] all end up in the params hash - to be used in my actions

# current_user comes out of the headers via the token - not part of the params hash
