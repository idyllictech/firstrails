class CreateSectionEdits < ActiveRecord::Migration[5.2]
  def self.up
    create_table :section_edits do |t|
    	t.references	:admin_users
    	t.references 	:sections
    	t.string	"summary", :limit => 255
      t.timestamps
    end
    add_index	:section_edits, ["admin_users_id","sections_id"]
  end
  def self.down
  	drop_table :section_edits
  end
end
