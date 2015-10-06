class AddArchivedToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :archived, :boolean, null: false, default: false
  end
end
