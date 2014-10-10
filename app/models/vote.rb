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

  belongs_to :user
  belongs_to :episode
  belongs_to :tag
end
