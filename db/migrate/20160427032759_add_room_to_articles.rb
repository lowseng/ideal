class AddRoomToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :bathroom, :integer 
    add_column :articles, :bedroom, :integer
  end
end