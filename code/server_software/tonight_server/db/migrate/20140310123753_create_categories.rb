class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :cat_name
      t.references :events

      t.timestamps
    end
  end
end
