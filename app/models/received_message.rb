class ReceivedMessage < ActiveRecord::Base
  belongs_to :user
  belongs_to :message, inverse_of: :received_messages
end
