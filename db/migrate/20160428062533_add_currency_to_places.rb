class AddCurrencyToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :currency, :text
  end
end
