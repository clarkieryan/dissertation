class AddEventsIdToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :events_id, :integer
  end
end
