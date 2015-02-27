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
  mount_uploader :image2x, ImageUploader
  mount_uploader :image3x, ImageUploader
  
  #many to mant
  has_many :program_categories, dependent: :destroy
  has_many :programs, -> {order("subscriberz_count desc")}, through: :program_categories

  has_many :user_categories, dependent: :destroy
  has_many :subscribers , through: :user_categories, source: :user

  validates :title, :presence => true
end
