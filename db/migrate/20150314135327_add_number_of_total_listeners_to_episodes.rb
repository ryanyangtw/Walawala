class AddNumberOfTotalListenersToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :number_of_total_listeners, :integer, default: 0
  end
end
