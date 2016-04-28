class AddPreferuomToUsers < ActiveRecord::Migration
  def change
    add_column :users, :preferuom, :text
  end
end
