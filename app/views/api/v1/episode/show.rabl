object @episode 
cache @episode
attributes :id, :title, :description

node(:audio_url){|episode| episode.audio_url}
node(:href){|episode| episode_path(episode)}


child :program => "parent_program" do |program|
  attributes :id, :subject, :introduction
  node(:image_url){ |program| program.image_url }
end