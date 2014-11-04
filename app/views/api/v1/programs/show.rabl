object @program 
cache @program
attributes :id, :subject, :introduction

#node(:image_url){ |program| program.image_url }
node(:href){|program| program_path(program)}

node :image do |program|
{sqdefault: program.image.url(:mobile_sq_default), 
 mqdefault: program.image.url(:mobile_mq_default),
 hqdefault: program.image.url(:mobile_hq_default)}
end
#node(:image_sqdefault){ |program| program.image.url(:mobile_sq_default)}
#node(:image_mqdefault){ |program| program.image.url(:mobile_mq_default)}
#node(:image_hqdefault){ |program| program.image.url(:mobile_hq_default)}

node(:subscribed){|program| program.subscribers.exists?(current_user) ? 'true' : 'false'}



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