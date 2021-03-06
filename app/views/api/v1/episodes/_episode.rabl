#cache @episode

attributes :id, :title, :description, :length_of_audio, :created_at

node(:audio_url){|episode| episode.audio.url}
node(:href){|episode| episode_path(episode)}
#node(:length){|episode| episode.length_of_audio }

if(locals[:show_parent_program])
  child :program => "parent_program" do |program|
    extends 'v1/programs/_program',locals: {show_episodes: false}
    
    #attributes :id, :subject, :introduction
    #node :image do |program|
    #  {sqdefault: program.image.url(:mobile_sq_default), 
    #   mqdefault: program.image.url(:mobile_mq_default),
    #   hqdefault: program.image.url(:mobile_hq_default)}
    #end
    #   #node(:subscribed){|program| program.subscribers.exists?(current_user) ? 'true' : 'false'}
    #   
    #   #node(:image_sqdefault){ |program| program.image.url(:mobile_sq_default)}
    #   #node(:image_mqdefault){ |program| program.image.url(:mobile_mq_default)}
    #   #node(:image_hqdefault){ |program| program.image.url(:mobile_hq_default)}
    #   #node(:image_url){ |program| program.image_url }
  end
end



@tags = Tag.all
child(@tags) do
  attributes :id, :title
  node(:num_of_votes){|tag| tag.num_of_votes(locals[:object])}
  node(:has_voted){|tag| current_user.has_voted?(tag, locals[:object]) }
end



#node(:tags) do 
#  @tags_arr.each do |tag|
#    tag
#  end
#end


# node(:tags) do 
#   @tags.each do |tag|
#     node(:title){ tag.title }
#     #{title: tag.title,
#     # num: tag.num_of_votes(@episode)}
#   end
# end





#collection @tags
#attributes :id, :title
  #node(:num){|tag| tag.num_of_votes(@episode)}

