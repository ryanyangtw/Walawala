# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  name                   :string(255)
#  provider               :string(255)
#  uid                    :string(255)
#  avatar                 :string(255)
#  authentication_token   :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

  mount_uploader :avatar, ImageUploader

  # one to many
  has_many :programs

  #many to many
  has_many :user_programs, dependent: :destroy
  has_many :subscribed_programs, through: :user_programs, source: :program
  has_many :subscribed_episodes, through: :subscribed_programs, source: :episodes

  #many to many
  has_many :user_categories, dependent: :destroy
  has_many :subscribed_categories, through: :user_categories, source: :category, after_add: :subscribe_programs_in_category, after_remove: :unsubscribe_programs_in_category 

  #many_to_many voted episode. Didn't implement
  has_many :votes 
  has_many :voted_episodes, through: :votes, source: :episode

  #one to many
  has_many :feedbacks


  before_save :ensure_authentication_token

  #before_save {|user| user.subscribe_hot_program_in_categories if user.subscribed_category_ids_changed?}


  def customize_episodes(page=1 , per_page=15)
    # TODO: Should inplement indeed customize episodes
    #self.subscribed_episodes.order('id desc').limit(20)

    per_page = 15 if per_page.blank?
    page = 1 if page.blank?
    
    # Recommend newest episode from hot 3 program in subscribed category
    recommended_array = []
    3.times do |index|
      self.subscribed_categories.each do |c|
        p = c.programs.order('subscriberz_count desc').offset(index).first
        if p.present? && !self.subscribed_programs.exists?(p)
          recommended_array << p.episodes.last
        end
      end
    end

    #We will recommend 3 special episode in every 15 episodes
    num_of_recomended_episodes_per_page = 3
    selected_recommended_episodes = recommended_array.slice( (page-1)*num_of_recomended_episodes_per_page, num_of_recomended_episodes_per_page) || []


    # Caculate episodes offset point 
    if((page-2)*num_of_recomended_episodes_per_page < recommended_array.size)
      offset_point = (page-1) * (per_page - num_of_recomended_episodes_per_page)
    else
      offset_point = ((page-1) * per_page) - recommended_array.size
    end

    original_subscribed_episodes = self.subscribed_episodes.order('updated_at desc').limit(per_page-selected_recommended_episodes.size).offset(offset_point)
    original_subscribed_episodes = original_subscribed_episodes.to_a

    customization = []
    length = original_subscribed_episodes.size

    # Combined the recommended_array and original_subscribed_episodes to customized_episodes
    (1..15).each do |index|
      if( index%4 == 0 && !recommended_array.empty?)
        customization << recommended_array.shift
      elsif( !original_subscribed_episodes.empty?  )
        customization << original_subscribed_episodes.shift
      else
        break
      end
    end

    # TODO: Cache Recommendation Result
    customization
    
  end

  def renew_data!
    new_count = self.sign_in_count + 1
    self.update(sign_in_count: new_count)
  end

  # TODO: (Notice) notice that calling unsubscribed method is before calling subscribe method
  # TODO: (Notice) notice that if category have already subscribed by user, It will not trigger subscribe programs method 
  # The hook of association like after_add will send each instance(category) into below method
  def subscribe_programs_in_category(category)
    category.programs.order('subscriberz_count desc').limit(3).each do |p|
      begin
        self.subscribed_programs << p
      # Rescue RecordInvalid if the user had already subscribed this program 
      rescue ActiveRecord::RecordInvalid => e
        next
      end
    end 
    #program_ids_arr = []
    #category.programs.order('subscriberz_count desc').limit(3).each do |p|
    #  #self.subscribe_program!(p)
    #  program_ids_arr.push(p.id)
    #end 
    #self.subscribed_program_ids = program_ids_arr
  end

  def unsubscribe_programs_in_category(category)
    self.subscribed_programs.each do |p|
      if p.categories.exists?(category)
        self.subscribed_programs.destroy(p)
      end
    end
  end



  def subscribe_program!(program)
    self.subscribed_programs << program
  end

  def cancel_subscribed_program!(program)
    self.subscribed_programs.destroy(program)
  end


  def has_subscriptions?
    self.subscribed_programs.present?
  end

  def already_voted?(episode)
    #self.evaluated_programs.exists?(program)
    self.voted_episode.exists?(episode)
  end

  def already_subscribed?(program)
    self.subscribed_programs.exists?(program)
  end

  def ensure_authentication_token
    self.authentication_token ||= generate_authentication_token
  end

  def change_authentication_token!
    self.authentication_token = generate_authentication_token
    self.save
  end

  def avatar_url
    self.avatar.url if self.avatar.present?
  end


  def role?(checking_role)
    self.role == checking_role.to_s
  end

  def change_role(new_role)
    self.update_attribute(:role, new_role)
  end

  def created_today?
    self.created_at.to_date == Date.today
  end

  def has_voted?(tag, episode)
    self.votes.where(tag: tag, episode:episode).first ? true : false
  end

  def cancel_vote(tag, episode)
    vote = self.votes.where(tag:tag,episode:episode)
    self.votes.destroy(vote)
  end



  def self.from_omniauth(auth)
    
    where(auth.slice(:provider, :uid)).first_or_create do |user|


      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      
      if auth.info.image.present?

        avatar_url = process_uri(auth.info.image)
        #user.remote_avatar_url = URI.parse(avatar_url)
        user.remote_avatar_url = avatar_url

      end
      # user.avatar = URI.parse(avatar_url) 

      #if auth.info.image.present?
      # require 'open-uri'
      # require 'open_uri_redirections'
      # avatar_url = open(auth.info.image, :allow_redirections => :safe) do |r|
      #   r.base_uri.to_s
      # end
      # #avatar_url = process_uri(auth.info.image)
      # user.avatar = URI.parse(avatar_url) 
      #end
      #user.avatar = auth.info.image # assuming the user model has an image
      #user.avatar =  URI.parse(auth.info.image) if auth.info.image?
    end
  end


  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  

  private
    def self.process_uri(uri)
      require 'open-uri'
      require 'open_uri_redirections'
      open(uri, :allow_redirections => :safe) do |r|
        r.base_uri.to_s
      end
    end

    def generate_authentication_token
      loop do
        token = Devise.friendly_token
        break token unless User.where(authentication_token: token).first
      end
    end



end
