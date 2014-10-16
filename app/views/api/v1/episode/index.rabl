collection @episodes ,:root => "episode"
cache @episodes
attributes :id, :title, :description

node(:audio_url){|episode| episode.audio.url}
node(:href){|episode| episode_path(episode)}
node(:length){|episode| episode.length_of_audio }

child :program => "parent_program" do |program|
  attributes :id, :subject, :introduction
  node(:image_url){ |program| program.image.url(:small) }
  #node(:image_url){ |program| program.image_url }
end