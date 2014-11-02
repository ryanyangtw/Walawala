# == Schema Information
#
# Table name: programs
#
#  id           :integer          not null, primary key
#  subject      :string(255)
#  introduction :text
#  image        :string(255)
#  user_id      :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Program < ActiveRecord::Base

  mount_uploader :image, ImageUploader


  #one to many
  belongs_to :owner, class_name: "User", foreign_key: :user_id

  #one to many
  has_many :episodes, dependent: :destroy

  #many to many 
  has_many :user_programs, dependent: :destroy
  has_many :subscribers, through: :user_programs, source: :user

  #many to many
  has_many :program_category, dependent: :destroy
  has_many :categories, through: :program_category

  #many to many
  has_many :votes, dependent: :destroy
  has_many :voter, through: :votes, source: :user



  def self.search(keyword)
    if keyword.present?
      where('subject LIKE ?', "%#{keyword}%")
    end
  end

  def add_subscriber!(subscriber)
    self.subscribers << subscriber
  end

  #def add_evaluator!(evaluator)
  #  self.evaluators << evaluator
  #end

  #def update_last_episode_uploaded_at(time)
  #  #self.last_episode_uploaded_at = time
  #  #self.save!
  #  # self.errors.to_a
  #   self.update_column(:last_episode_uploaded_at, time)
  #end

  def remove_subscriber!(user)
    self.subscribers.destroy(user)
  end

  #def vote!(evaluation_id, user_id)
  #  program_evaluations = self.program_evaluations.build(:evaluation_id=>evaluation_id, :user_id => user_id)
  #  program_evaluations.save
  #end


  #def image_url
  #  return self.image.url(:small)
  #end

end
