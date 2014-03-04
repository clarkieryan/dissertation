class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :ref_id, :limit => 8
      t.integer :venue_id
      t.string :name
      t.text :desc
      t.integer :start_time
      t.integer :end_time
      t.string :timezone
      t.integer :venue
      t.integer :updated_at

      t.timestamps
    end
  end
end
