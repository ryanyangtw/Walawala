# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Category < ActiveRecord::Base

  mount_uploader :image, ImageUploader
  
  #many to mant
  has_many :program_categories, dependent: :destroy
  has_many :programs, through: :program_categories

  has_many :user_categories, dependent: :destroy
  has_many :subscriber , through: :user_categories, source: :user

  validates :title, :presence => true
end
