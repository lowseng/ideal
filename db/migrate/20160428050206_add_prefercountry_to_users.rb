class AddPrefercountryToUsers < ActiveRecord::Migration
  def change
    add_column :users, :prefercountry, :text
  end
end