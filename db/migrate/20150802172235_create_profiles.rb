class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.text :moniker, null: false
      t.text :location, null: false
      t.text :email_or_phone, null: false
      t.integer :phone_number
      t.integer :number_of_sent_messages
      t.integer :number_of_received_messages
      t.text :selected_time, null: false

      t.timestamps null: false
    end
  end
end
