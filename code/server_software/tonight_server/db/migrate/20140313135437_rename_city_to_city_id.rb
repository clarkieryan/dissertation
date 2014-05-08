class RenameCityToCityId < ActiveRecord::Migration
  def change
  	rename_column :venues, :city, :city_id 
  end
end
