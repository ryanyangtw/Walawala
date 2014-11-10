# == Schema Information
#
# Table name: votes
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  episode_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class Vote < ActiveRecord::Base

  belongs_to :voter, class_name: "User", foreign_key: :user_id 
  belongs_to :episode
  belongs_to :tag

  validates :user_id, :episode_id, :tag_id, presence: true

  validates_uniqueness_of :voter, scope: [:episode_id, :tag_id]
end
