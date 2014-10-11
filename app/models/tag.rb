# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Tag < ActiveRecord::Base
  has_many :votes
  has_many :voted_episodes, through: :votes, source: :episode
  has_many :voter, through: :votes, source: :user
  #has_many :voted_user, through: :vote, source: :user


  validates :title, :presence => true

end
