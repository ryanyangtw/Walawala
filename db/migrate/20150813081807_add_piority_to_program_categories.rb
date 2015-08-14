class AddPiorityToProgramCategories < ActiveRecord::Migration
  def change
    add_column :program_categories, :piority, :integer, default: 0
  end
end
