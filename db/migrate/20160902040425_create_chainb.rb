class CreateChainb < ActiveRecord::Migration
  def change
    create_table :chainbs do |t|
      t.string :name
      t.references :chaina, index: true
      t.timestamps
    end
  end
end
