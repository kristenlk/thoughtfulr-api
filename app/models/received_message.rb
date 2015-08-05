class ReceivedMessage < ActiveRecord::Base
  # has_many :users, through: :messages
  belongs_to :user
  belongs_to :message, inverse_of: :received_messages


  # def send_message(from:, to:, body:)
  # end
end
