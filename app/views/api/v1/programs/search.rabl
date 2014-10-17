collection @programs ,:root => "programs"
cache @programs
attributes :id, :subject, :introduction

node(:href){|program| program_path(program)}
node :image do |program|
{sqdefault: program.image.url(:mobile_sq_default), 
 mqdefault: program.image.url(:mobile_mq_default),
 hqdefault: program.image.url(:mobile_hq_default)}
end



child :owner => "owner" do |owner|
  attributes :id, :name
  node(:avatar_url){owner.avatar_url}
end

child :episodes do
  attributes :id, :title
  node(:audio_url){|episode| episode.audio_url}
end


