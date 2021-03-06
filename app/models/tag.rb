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
  has_many :votes, dependent: :destroy
  has_many :voted_episodes, through: :votes, source: :episode
  has_many :voter, through: :votes, source: :voter
  #has_many :voted_user, through: :vote, source: :user


  validates :title, :presence => true

  def num_of_votes(episode)
    self.voted_episodes.where(id: episode.id).size 
  end

end
