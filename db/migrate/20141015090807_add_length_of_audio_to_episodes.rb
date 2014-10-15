class AddLengthOfAudioToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :length_of_audio, :integer, default: 0
  end
end
