class AddFacilityToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :xpool, :boolean, default: false  
    add_column :articles, :xsqua, :boolean, default: false
    add_column :articles, :xplay, :boolean, default: false
    add_column :articles, :xbalc, :boolean, default: false
    add_column :articles, :xgymn, :boolean, default: false
    add_column :articles, :xmini, :boolean, default: false
    add_column :articles, :xjogg, :boolean, default: false
    add_column :articles, :xcabl, :boolean, default: false
    add_column :articles, :xtenn, :boolean, default: false
    add_column :articles, :xpark, :boolean, default: false
    add_column :articles, :xsecu, :boolean, default: false
    add_column :articles, :xlift, :boolean, default: false
  end
end
