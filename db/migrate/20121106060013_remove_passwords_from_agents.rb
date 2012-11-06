class RemovePasswordsFromAgents < ActiveRecord::Migration
  def up
    remove_column :agents, :password_hash
    remove_column :agents, :password_salt
  end

  def down
    add_column :agents, :password_hash, :string
    add_column :agents, :password_salt, :string
  end
end
