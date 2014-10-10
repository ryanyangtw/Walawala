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

  #one to many
  has_many :episodes

  #many to many 
  has_many :user_programs
  has_many :subscribers, through: :user_programs, source: :user

  #many to many
  has_many :program_category
  has_many :categories, through: :program_category

  has_many :votes
  has_many :voter, through: :votes, source: :user

end
