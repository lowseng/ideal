class AddLocationToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :place, :text
    add_column :articles, :region, :text
    add_column :articles, :area, :text
  end
end