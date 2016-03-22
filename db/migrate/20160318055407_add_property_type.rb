class AddPropertyType < ActiveRecord::Migration
  def change
    add_column :articles, :proptype, :text
  end
end
