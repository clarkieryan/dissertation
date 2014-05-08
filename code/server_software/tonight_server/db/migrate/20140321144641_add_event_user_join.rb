class AddEventUserJoin < ActiveRecord::Migration
  def change
	create_table "events_users", :id => false do |t|
		t.column "user_id", :integer, :null => false
		t.column "event_id",  :integer, :null => false
	end
  end
end
