class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.text :content
      t.integer :feedback_subject_id
      t.integer :user_id

      t.timestamps
    end
  end
end
