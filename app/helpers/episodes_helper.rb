module EpisodesHelper

  def render_episode_title_with_index(index, episode)
    "#{index+1}.#{episode.title}"
  end

  def render_episode_title(title)
    title
  end

  def render_episode_description(description)
    description
  end

end
