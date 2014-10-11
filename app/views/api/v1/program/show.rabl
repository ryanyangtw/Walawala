object @program 
cache @program
attributes :id, :subject, :introduction

node(:image_url){ |program| program.image_url }



child :owner => "owner" do |owner|
	attributes :id, :namem, :description
	node(:avatar_url){owner.avatar_url}
end

child :episodes do
	attributes :id, :title
	node(:audio_url){|episode| episode.audio_url}
	#node(:href){|episode| program_episode_path(@program, episode)}
	node(:href){|episode| episode_path(episode)}
end
