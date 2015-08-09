module EpisodesHelper

  def render_episode_title_with_index(index, episode)
    "#{index+1}.#{episode.title}"
  end

end
