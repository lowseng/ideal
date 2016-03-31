class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :text
    add_column :users, :telephone, :text
    add_column :users, :agentno, :text
    add_column :users, :company, :text
  end
end
