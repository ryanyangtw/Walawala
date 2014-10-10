class CreateProgramCategories < ActiveRecord::Migration
  def change
    create_table :program_categories do |t|
      t.integer :program_id
      t.integer :category_id
      t.timestamps
    end
  end
end
