class View < ActiveRecord::Base

  belongs_to :listener, class_name: "User", foreign_key: :user_id
  belongs_to :episode, counter_cache: :number_of_unique_listeners

  # before_save will fire twice if using create method
  after_save :increase_numbers

  validates :user_id, :episode_id, presence: true

  #confirm everyone will only have one view for dpecific episode 
  validates_uniqueness_of :episode, scope: :user_id




  #private
  def increase_numbers
    self.update_column(:numbers, self.numbers+1)
    #self.numbers = self.numbers + 1
    # sync the total numbers in episode
    self.episode.increase_number_of_total_listeners
  end

end