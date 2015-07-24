class AddTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :token, :string, null: false
    # if the user exists, I'm requiring they have a token, and I'm requiring it's unique
    add_index :users, :token, unique: true
  end
end
