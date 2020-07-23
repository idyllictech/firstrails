class AlterPages < ActiveRecord::Migration[5.2]
  def self.up  	
  	puts "*** About to add an index to page id ***"
  	add_index("sections", "pages_id")
  	puts "*** About to add an index to subjects id ***"
  	add_index("pages", "subjects_id")
  end
  def self.down
  	remove_index("pages", "subjects_id")
  	remove_index("sections", "pages_id")
  end
end
