class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.string :subject
      t.text :introduction
      t.string :image
      t.integer :user_id
      t.timestamps
    end
  end
end
