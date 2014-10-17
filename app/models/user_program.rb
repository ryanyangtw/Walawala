# == Schema Information
#
# Table name: user_programs
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  program_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class UserProgram < ActiveRecord::Base
  belongs_to :user 
  belongs_to :program, counter_cache: :subscriberz_count
end
