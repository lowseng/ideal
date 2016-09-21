class AddTitleToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :size1, :decimal, :precision => 10, :scale => 2
    add_column :articles, :titletype, :text
  end
end
