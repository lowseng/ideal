class CreatePaypals < ActiveRecord::Migration
  def change
    create_table :paypals do |t|
      t.string :item_number
      t.string :invoice

      t.timestamps null: false
    end
  end
end
