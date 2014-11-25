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


  def customize_episodes
    #TODO: should inplument indeed customize episodes
    self.subscribed_episodes.order('id desc').limit(20)
  end

  def renew_data!
    new_count = self.sign_in_count + 1
    self.update(sign_in_count: new_count)
  end

  #TODO: Notice that calling unsubscribed method is before calling subscribe method
  #TODO: Notice that if category have already subscribed by user, It will not trigger subscribe programs method

  def subscribe_programs_in_category(category)
    category.programs.order('subscriberz_count desc').limit(3).each do |p|
      begin
        self.subscribed_programs << p
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
