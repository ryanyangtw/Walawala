class AddMultpleImageToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :image2x, :string
    add_column :categories, :image3x, :string
  end
end
