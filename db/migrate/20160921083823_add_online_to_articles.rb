class AddOnlineToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :xonline, :boolean, default: true
  end
end
