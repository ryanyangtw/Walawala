class Feedback < ActiveRecord::Base

  belongs_to :feedback_subject
  belongs_to :user

  validate :content, presence: true
end
