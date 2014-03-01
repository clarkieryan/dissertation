class AddDecriptionToText < ActiveRecord::Migration
  def change
    	change_column :venues, :desc, :text
  end
end
