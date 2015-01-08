attributes :id, :title, :description


node(:href){|category| category_path(category)}
node :image do |category|
  {sqdefault: category.image_url, 
   mqdefault: category.image_url,
   hqdefault: category.image_url}
end

#node (:image){|category| category.image_url}

node(:subscribed){|category| category.subscribers.exists?(current_user) ? 'true' : 'false'}


#child :programs do
#  attributes :id, :subject, :introduction
#
#  node(:href){|program| program_path(program)}
#  
#  node :image do |program|
#    {sqdefault: program.image.url(:mobile_sq_default), 
#     mqdefault: program.image.url(:mobile_mq_default),
#     hqdefault: program.image.url(:mobile_hq_default)}
#  end
#end