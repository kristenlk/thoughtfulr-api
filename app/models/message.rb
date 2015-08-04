class Message < ActiveRecord::Base
  belongs_to :user, inverse_of: :messages
  has_many :received_messages, inverse_of: :message
end
