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
  #belongs_to :owner, through: :program,class_name: "User"

  has_many :votes, dependent: :destroy

  validates :audio, presence: true , on: [:create]

  before_create :calculate_length_of_audio


  #def update_program
  # self.program.update_last_episode_uploaded_at(self.created_at)
  #end

  #def audio_url
  # self.audio.url if self.audio.present?
  #end

  def updated_today?
    self.updated_at.to_date == Date.today
  end

  private
  def calculate_length_of_audio
    if self.audio.present?
      self.length_of_audio = AudioInfo.open(self.audio.path).length
    else
      0
    end

  end
end
