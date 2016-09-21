class ChangeTrnToTxnPaypals < ActiveRecord::Migration
  def change
    remove_column :paypals, :trn_id
    remove_column :paypals, :trn_type
    add_column :paypals, :txn_id, :string
    add_column :paypals, :txn_type, :string
  end
end
