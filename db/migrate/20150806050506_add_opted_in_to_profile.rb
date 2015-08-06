class AddOptedInToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :opted_in, :boolean
  end
end
