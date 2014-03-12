class RenameCatNameToName < ActiveRecord::Migration
  def change
  	rename_column :categories, :cat_name, :name
  end
end
