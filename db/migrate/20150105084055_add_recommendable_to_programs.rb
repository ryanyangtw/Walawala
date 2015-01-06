class AddRecommendableToPrograms < ActiveRecord::Migration
  def change
    add_column :programs, :recommendable, :boolean, default: false
  end
end
