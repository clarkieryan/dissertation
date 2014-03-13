class ChangeCityToInteger < ActiveRecord::Migration
	def change
		change_column :venues, :city, 'integer USING CAST(city AS integer)'
	end
end
