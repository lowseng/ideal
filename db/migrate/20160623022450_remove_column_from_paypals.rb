class RemoveColumnFromPaypals < ActiveRecord::Migration
  def change
   remove_column :paypals, :Payment_fee
  end
end
