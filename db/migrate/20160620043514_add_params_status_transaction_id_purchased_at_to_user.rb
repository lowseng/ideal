class AddParamsStatusTransactionIdPurchasedAtToUser < ActiveRecord::Migration
  def change
    add_column :users, :notification_params, :text
    add_column :users, :status, :string
    add_column :users, :transaction_id, :string
    add_column :users, :purchased_at, :datetime
  end
end
