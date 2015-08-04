class CreateReceivedMessages < ActiveRecord::Migration
  def change
    create_table :received_messages do |t|

      t.timestamps null: false
    end
  end
end
