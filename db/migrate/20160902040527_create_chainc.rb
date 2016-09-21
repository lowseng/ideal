class CreateChainc < ActiveRecord::Migration
  def change
    create_table :chaincs do |t|
      t.string :name
      t.references :chainb, index: true
      t.timestamps
    end
  end
end
