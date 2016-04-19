class AddCategoryToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :category, :text
  end
end
