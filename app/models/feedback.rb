class Feedback < ActiveRecord::Base

  belongs_to :feedback_subject
  belongs_to :user

  validates :content, presence: true
end
