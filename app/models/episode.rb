# == Schema Information
#
# Table name: episodes
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :string(255)
#  audio       :string(255)
#  program_id  :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Episode < ActiveRecord::Base

  mount_uploader :audio, AudioUploader

  belongs_to :program, touch: true
  has_many :votes

  validates :audio, presence: true 


  #def update_program
  # self.program.update_last_episode_uploaded_at(self.created_at)
  #end

  def audio_url
   self.audio.url if self.audio.present?
  end
end
