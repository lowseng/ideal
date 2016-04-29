class AddOtherinfoToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :otherinfo, :text
  end
end
