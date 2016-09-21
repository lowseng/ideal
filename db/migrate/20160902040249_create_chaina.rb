class CreateChaina < ActiveRecord::Migration
  def change
    create_table :chainas do |t|
      t.string :name
      t.timestamps
    end
  end
end
