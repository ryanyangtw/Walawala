class CreateFeedbackSubjects < ActiveRecord::Migration
  def change
    create_table :feedback_subjects do |t|
      t.string :title

      t.timestamps
    end
  end
end
