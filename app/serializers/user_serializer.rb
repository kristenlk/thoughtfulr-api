class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :num_messages_left_to_receive

  def num_messages_left_to_receive
    num_sent_messages = object.messages.count
    num_received_messages = object.received_messages.count
    num_sent_messages - num_received_messages
  end

end
