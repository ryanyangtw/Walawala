class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :episode_id, index: true
      t.integer :user_id, index: true
      t.text :content
      t.timestamps
    end
  end
end
