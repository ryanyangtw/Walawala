collection @programs ,:root => "programs"
cache @programs
attributes :id, :subject, :introduction

node(:image_url){ |program| program.image.url(:small) }
node(:href){|program| program_path(program)}

#node(:links) do |program|
#	{:owner => program.owner, :episodes => program.episode_ids}
#
#end

child :owner => "owner" do |owner|
	attributes :id, :name
	node(:avatar_url){owner.avatar_url}
end

child :episodes do
	attributes :id, :title
	node(:audio_url){|episode| episode.audio_url}
end



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