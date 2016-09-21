class AddEtcToPaypals < ActiveRecord::Migration
  def change
    add_column :paypals, :m_id, :string
    add_column :paypals, :quantity, :string
    add_column :paypals, :item_name, :string
    add_column :paypals, :mc_currency, :string
    add_column :paypals, :mc_gross, :string
    add_column :paypals, :mc_fee, :string
    add_column :paypals, :payment_gross, :string
    add_column :paypals, :Payment_fee, :string
    add_column :paypals, :handling_amount, :string
    add_column :paypals, :shipping, :string
    add_column :paypals, :tax, :string
    add_column :paypals, :payment_status, :string
    add_column :paypals, :payment_type, :string
    add_column :paypals, :payment_date, :string
    add_column :paypals, :trn_id, :string
    add_column :paypals, :trn_type, :string
    add_column :paypals, :first_name, :string
    add_column :paypals, :last_name, :string
    add_column :paypals, :address_name, :string
    add_column :paypals, :address_street, :string
    add_column :paypals, :address_city, :string
    add_column :paypals, :address_state, :string
    add_column :paypals, :address_zip, :string
    add_column :paypals, :address_country, :string
    add_column :paypals, :address_country_code, :string
    add_column :paypals, :payer_id, :string
    add_column :paypals, :payer_email, :string
    add_column :paypals, :payer_status, :string
    add_column :paypals, :business, :string
    add_column :paypals, :receiver_email, :string
    add_column :paypals, :receiver_id, :string
  end
end
