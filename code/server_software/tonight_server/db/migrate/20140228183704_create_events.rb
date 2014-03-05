class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :ref_id, :limit => 8
      t.integer :venue_id
      t.string :name
      t.text :desc
      t.datetime :start_time
      t.datetime :end_time
      t.string :timezone
      t.integer :venue
      t.integer :updated_at

      t.timestamps
    end
  end
end
