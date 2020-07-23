class AlterSections < ActiveRecord::Migration[5.2]
  def self.up
  	change_column("sections", "visible", :boolean, :null => false, :default => 0)
  	 	
  end
  def self.down
  	change_column("sections", "visible", :boolean, :null => false, :default => 0)  	
  end
end
