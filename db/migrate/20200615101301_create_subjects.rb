class CreateSubjects < ActiveRecord::Migration[5.2]
  def self.up
    create_table :subjects do |t|
    	t.string "name", :limit => 150, :null => false
    	t.integer "position", :limit => 4, :default => 0
    	t.boolean "visible", :null => false
      t.timestamps
    end
  end
  def self.down
    drop_table :subjects 
  end
end
 