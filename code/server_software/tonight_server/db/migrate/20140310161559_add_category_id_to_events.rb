class AddCategoryIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :categories_id, :integer
  end
end
