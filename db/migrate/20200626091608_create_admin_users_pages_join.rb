class CreateAdminUsersPagesJoin < ActiveRecord::Migration[5.2]
  def self.up
    create_table :admin_users_pages, :id => false do |t|
    	t.integer	"admin_user_id", :limit => 3, :default => 0
   		t.integer	"page_id",	:limit => 3, :default => 0
    end
    add_index	:admin_users_pages, ["admin_user_id", "page_id"]
  end


  def self.down
  	drop_table	:admin_users_pages
  end
end
