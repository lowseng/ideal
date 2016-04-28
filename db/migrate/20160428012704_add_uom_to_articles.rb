class AddUomToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :uom, :text
    add_column :articles, :currency, :text
  end
end
