class AddProgramsCountToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :programz_count, :integer, default: 0
  end
end
