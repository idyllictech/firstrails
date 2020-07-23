class AlterUsers < ActiveRecord::Migration[5.2]
  def self.up
  	rename_table("users", "admin_users")
  	add_column("admin_users", "username", :string, :limit => 150)
	change_column("admin_users", "email", :string, :limit => 150)  	
  	rename_column("admin_users", "password", "hashed_password")
  	add_column("admin_users", "salt", :string, :limit => 50)
  	puts "*** About to add an index ***"
  	add_index("admin_users", "username")

  end
  def self.down
  	remove_index("admin_users", "username")
  	remove_column("admin_users", "salt")
  	rename_column("admin_users", "hashed_password", "password")
  	change_column("admin_users", "email", :limit => 250, :null => false) 
  	remove_column("admin_users", "username")
  	rename_table("admin_users", "users")

  end
end
