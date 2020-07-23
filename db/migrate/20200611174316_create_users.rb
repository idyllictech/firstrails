class CreateUsers < ActiveRecord::Migration[5.2]
  def self.up
    create_table :users do |t|
      t.string "first_name", :limit => 150
      t.string "last_name", :limit => 150
      t.string "email", :limit => 250, :default => "a", :null => false
      t.string "password", :limit => 250    	
      t.timestamps
    end
  end
  def self.down
  	drop_table :users
  end
end
