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
         :recoverable, :rememberable, :trackable, :validatable

  # one to many
  has_many :programs

  #many to many
  has_many :user_programs
  has_many :subscribed_programs, through: :user_programs, source: :program

  #many to many
  has_many :user_categories
  has_many :subscribed_categories, through: :user_categories, source: :category

  #many_to_many voted episode. Didn't implement

end
