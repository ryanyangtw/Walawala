class AddArchivedToPrograms < ActiveRecord::Migration
  def change
    add_column :programs, :archived, :boolean, null: false, default: false
  end
end
