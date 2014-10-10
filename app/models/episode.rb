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

  belongs_to :program
  has_many :votes
end
