class AddMessageIdToReceivedMessages < ActiveRecord::Migration
  def change
    add_reference :received_messages, :message, index: true, foreign_key: true
  end
end
