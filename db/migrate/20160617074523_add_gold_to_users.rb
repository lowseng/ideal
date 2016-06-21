class AddGoldToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gold, :boolean, default: false 
  end
end
