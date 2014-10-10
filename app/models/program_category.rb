# == Schema Information
#
# Table name: program_categories
#
#  id          :integer          not null, primary key
#  program_id  :integer
#  category_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class ProgramCategory < ActiveRecord::Base

  belongs_to :program
  belongs_to :category
end
