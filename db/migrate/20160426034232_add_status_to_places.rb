class AddStatusToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :status, :boolean, default: false  
  end
end