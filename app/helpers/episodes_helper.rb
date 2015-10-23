module EpisodesHelper

  def render_episode_title_with_index(index, episode)
    "#{index+1}.#{episode.title}"
  end

  def render_episode_title(episode)
    truncate(episode.title, length: 18)
  end

  def render_episode_description(episode)
    simple_format(episode.description)
  end

  def render_episode_description_with_limit_length(episode)
    simple_format(truncate(episode.description, length: 100))
  end


  def render_episode_created_at(episode)
    # 2014.08.25
    episode.created_at.strftime("%Y.%m.%d") 
  end

end
