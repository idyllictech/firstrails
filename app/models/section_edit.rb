class SectionEdit < ApplicationRecord
	belongs_to	:editor, :class_name => "AdminUser", :foreign_key => "admin_users_id"
	belongs_to 	:section,  foreign_key: "sections_id" 
end
