module EpisodesHelper

  def render_episode_title_with_index(index, episode)
    "#{index+1}.#{episode.title}"
  end

  def render_episode_title(episode)
    episode.title
  end

  def render_episode_description(episode)
    episode.description
  end


  def render_episode_created_at(episode)
    # 2014.08.25
    episode.created_at.strftime("%Y.%m.%d") 
  end

end
