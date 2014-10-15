class AddLengthOfAudioToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :length_of_audio, :float, default: 0
  end
end
