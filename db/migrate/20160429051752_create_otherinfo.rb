class CreateOtherinfo < ActiveRecord::Migration
  def change
    create_table :otherinfos do |t|
      t.string :name
      t.references :place, index: true
      t.timestamps
    end
  end
end
