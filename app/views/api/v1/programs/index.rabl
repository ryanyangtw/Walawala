collection @programs ,:root => "programs"
#cache @programs

extends 'v1/programs/_program', locals: {show_episodes: false, show_owner: false}

#attributes :id, :subject, :introduction
#
#node(:href){|program| program_path(program)}
#node :image do |program|
#{sqdefault: program.image.url(:mobile_sq_default), 
# mqdefault: program.image.url(:mobile_mq_default),
# hqdefault: program.image.url(:mobile_hq_default)}
#end
#
##node(:image_sqdefault){ |program| program.image.url(:mobile_sq_default)}
##node(:image_mqdefault){ |program| program.image.url(:mobile_mq_default)}
##node(:image_hqdefault){ |program| program.image.url(:mobile_hq_default)}
#
#node(:subscribed){|program| program.subscribers.exists?(current_user) ? 'true' : 'false'}
#node(:num_of_subscribers){|program| program.subscribers.size}
#
##node(:links) do |program|
##	{:owner => program.owner, :episodes => program.episode_ids}
##
##end
#
#child :owner => "owner" do |owner|
#	attributes :id, :name
#	node(:avatar_url){owner.avatar_url}
#end
#
#child :episodes do
#	attributes :id, :title
#	node(:audio_url){|episode| episode.audio_url}
#end



#node(:new_url) { root_url }

#child :episodes do
#	attribute :id, :title
#end

#glue :owner do
#  attribute :id, :name
#end

#child :owner => "owner" do
#	attribute :id, :name
#end

#extends "v1/program/show"