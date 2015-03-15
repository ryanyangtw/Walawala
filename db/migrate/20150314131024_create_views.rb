class CreateViews < ActiveRecord::Migration
  def change
    create_table :views do |t|
      t.integer :user_id, index: true
      t.integer :episode_id, index: true
      t.integer :numbers, default: 0
      t.timestamps
    end
  end
end
