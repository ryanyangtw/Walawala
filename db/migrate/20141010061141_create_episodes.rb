class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.string :title
      t.string :description
      t.string :audio
      t.integer :program_id
      t.timestamps
    end
  end
end
