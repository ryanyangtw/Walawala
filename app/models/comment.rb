class Comment < ActiveRecord::Base
  belongs_to :user, class_name: "User", foreign_key: :user_id 
  belongs_to :episode

  validates :content, presence: true
  
end
