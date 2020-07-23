class AlterSubject < ActiveRecord::Migration[5.2]
  def change
  	change_column("subjects", "visible", :boolean, :default => false)
  end

end
