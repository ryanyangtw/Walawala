class AddNumberOfUniqueListenersToEpisodes < ActiveRecord::Migration
  def change
     add_column :episodes, :number_of_unique_listeners, :integer, default: 0
  end
end
