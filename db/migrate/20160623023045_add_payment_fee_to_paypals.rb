class AddPaymentFeeToPaypals < ActiveRecord::Migration
  def change
   add_column :paypals, :payment_fee, :string
  end
end
