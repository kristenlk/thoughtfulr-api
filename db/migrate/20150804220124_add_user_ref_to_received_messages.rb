class AddUserRefToReceivedMessages < ActiveRecord::Migration
  def change
    add_reference :received_messages, :user, index: true, foreign_key: true
  end
end
