class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.integer :ref_id, :limit => 8
      t.integert :venue_id, :limit => 8
      t.string :name
      t.text :desc
      t.string :street
      t.string :city
      t.string :county
      t.string :country
      t.string :post_code
      t.float :lat, :limit => 8
      t.float :lon, :limit => 8
      t.string :phone
      t.string :website

      t.timestamps
    end
  end
end
