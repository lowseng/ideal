class AddAreapriceToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :size, :decimal, :precision => 10, :scale => 2
    add_column :articles, :amount, :decimal, :precision => 10, :scale => 2
  end
end
