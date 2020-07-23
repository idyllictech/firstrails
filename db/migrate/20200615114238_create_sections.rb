class CreateSections < ActiveRecord::Migration[5.2]
  def change
    create_table :sections do |t|
    	t.string "name", :limit => 150, :null => false
    	t.integer "position", :limit => 3, :default => 0
    	t.boolean "visible", :null => false
    	t.string "content_type", :limit => 250
    	t.text "content"
    	t.integer  "pages_id", :limit => 3, :default => 0
      t.timestamps
    end
  end
end
