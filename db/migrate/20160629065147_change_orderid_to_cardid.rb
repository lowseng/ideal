class ChangeOrderidToCardid < ActiveRecord::Migration
  def change
    remove_column :card_transactions, :order_id
    add_column :card_transactions, :card_id, :integer   
  end
end
