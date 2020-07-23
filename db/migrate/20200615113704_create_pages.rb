class CreatePages < ActiveRecord::Migration[5.2]
  def self.up
    create_table :pages do |t|
    	t.string "name", :limit => 250, :null => false
    	t.string "permalink", :limit => 250, :default =>"a", :null => false
    	t.integer "position", :limit => 3, :default => 0
    	t.boolean "visible", :null => false
    	t.integer "subjects_id", :limit => 3, :default => 0
      t.timestamps
    end
  end
  def self.down
    drop_table :pages
  end
end
