class AddUserIdToPaypals < ActiveRecord::Migration
  def change
    add_column :paypals, :user_id, :integer
  end
end
