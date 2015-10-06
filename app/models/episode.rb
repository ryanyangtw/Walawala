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

  default_scope { where(archived: false) }

  mount_uploader :audio, AudioUploader

  belongs_to :program, touch: true
  #belongs_to :owner, through: :program, class_name: "User"

  has_many :votes, dependent: :destroy

  # many to many
  has_many :views, dependent: :destroy
  has_many :listeners, through: :views, source: :listener

  # many to one
  has_many :comments, dependent: :destroy


  validates :audio, presence: true , on: [:create]

  before_create :calculate_length_of_audio


  scope :sort_by_update_time, -> { order("updated_at desc") }
  #scope :sort_by_num_of_subscribers, -> { order("subscriberz_count desc") }



  #def update_program
  # self.program.update_last_episode_uploaded_at(self.created_at)
  #end

  #def audio_url
  # self.audio.url if self.audio.present?
  #end

  def updated_today?
    self.updated_at.to_date == Date.today
    #self.updated_at.to_date == DateTime.current.to_date
  end

  def increase_number_of_total_listeners
    self.update_column(:number_of_total_listeners, self.number_of_total_listeners + 1)

    # Notice: increment will fired the hook (before_save :increase_numbers) in model/view.rb twice
    #self.increment!(:number_of_total_listeners)
  end

  def increase_number_of_views(user)
    if self.listeners.exists?(user)
      view = self.views.where(listener: user).first
      view.increase_numbers
    else
      self.listeners << user
    end

  end

  ## There are some ernoding problems whrn outputing CSV
  # def self.to_csv(options = {})
  #   CSV.generate(options) do |csv|
  #     column_names_arr = ["ID", "UploadDate", "Title", "ParentProgram", "Uploader"]
  #     Category.all.each_with_index do |category, index|
  #       column_names_arr << "Category_#{index}_#{category.title}"
  #     end
  #     csv << column_names_arr 
  #     self.all.each do |episode|
  #       attributes_arr = []
  #       attributes_arr << episode.id 
  #       attributes_arr << episode.created_at
  #       attributes_arr << episode.title
  #       attributes_arr << episode.program.subject
  #       attributes_arr << episode.program.try(:owner).try(:name)
  #       Category.all.each do |category|
  #         attributes_arr <<  episode.program.categories.exists?(category) ? 1 : 0
  #       end

  #       csv << attributes_arr
  #     end
  #   end
  # end

  def archive
    self.archived = true
    self.save
  end

  private
  def calculate_length_of_audio
    if self.audio.present?
      self.length_of_audio = AudioInfo.open(self.audio.path).length
    end

  end



end
