class AddResidenceCountryToPaypals < ActiveRecord::Migration
  def change
    add_column :paypals, :residence_country, :string
  end
end
