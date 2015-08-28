class AddImageWebToCategories < ActiveRecord::Migration
  def change
     add_column :categories, :image_web, :string
  end
end
