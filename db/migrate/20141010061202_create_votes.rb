class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :tag_id, index: true
      t.integer :episode_id, index: true
      t.integer :user_id, index: true
      t.timestamps
    end
  end
end
