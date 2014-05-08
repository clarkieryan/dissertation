class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :name
      t.string :desc
      t.string :api
      t.string :filters
      t.string :toe
      t.string :output
      t.timestamps
    end
  end
end
