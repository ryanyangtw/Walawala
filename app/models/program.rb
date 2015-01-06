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

  ##many to many
  #has_many :votes, dependent: :destroy
  #has_many :voter, through: :votes, source: :user


  scope :sort_by_update_time, -> { order("updated_at desc") }
  scope :sort_by_num_of_subscribers, -> { order("subscriberz_count desc") }
  scope :recomendable, -> { where(recommendable: true) }


  #TODO: [Notice] This is official collection (from best radio)
  def self.official_collection(page=1, per_page=15)
    page = 1 if page.blank?
    per_page = 15 if per_page.blank?
    
    programs_list = Program.recomendable.sort_by_update_time.limit(per_page).offset(page-1)
    episodes_list = programs_list.map{|p| p.newest_episode }
    episodes_list
  end

  def self.search(keyword)
    if keyword.present?
      where('subject LIKE ?', "%#{keyword}%").sort_by_num_of_subscribers
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


  def updated_today?
    self.updated_at.to_date == Date.today
  end

  def set_to_recommendation
    self.update_column(:recommendable, true)
  end

  def cancel_from_recommendation
    self.update_column(:recommendable ,false)
  end

  def newest_episode
    self.episodes.last
  end

  #def vote!(evaluation_id, user_id)
  #  program_evaluations = self.program_evaluations.build(:evaluation_id=>evaluation_id, :user_id => user_id)
  #  program_evaluations.save
  #end


  #def image_url
  #  return self.image.url(:small)
  #end


  ##include AASM
##
  ##aasm do
  ##  state :checking, :initial => true
  ##  event :recheck do
  ##    transitions :from => [:on_shelf, :off_shelf], :to => :checking
  ##  end
##
##
  ##  stage :on_shelf
  ##  event :put_on do
  ##    transitions :from => :checking, :to => :on_shelf
  ##  end
##
  ##  state :off_shelf
  ##  event :take_down do 
  ##    transations :from => :checking, :to => :off_shelf
  ##  end
  ##  
  ##end



end
