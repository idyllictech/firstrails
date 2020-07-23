class AlterLink < ActiveRecord::Migration[5.2]
  def self.up
  	add_index("pages", "permalink")
  end
  def self.down
  	remove_index("pages", "permalink")
  end
end
