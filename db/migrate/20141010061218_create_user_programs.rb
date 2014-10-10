class CreateUserPrograms < ActiveRecord::Migration
  def change
    create_table :user_programs do |t|
      t.integer :user_id, index: true
      t.integer :program_id, index: true
      t.timestamps
    end
  end
end
