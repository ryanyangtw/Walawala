class AddSubscribersCountToPrograms < ActiveRecord::Migration
  def change
    add_column :programs, :subscriberz_count, :integer, default: 0
  end
end
