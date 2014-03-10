class AddCategoryEventJoin < ActiveRecord::Migration
	def change
		create_table "categories_events", :id => false do |t|
			t.column "category_id", :integer, :null => false
			t.column "event_id",  :integer, :null => false
		end
	end
end
