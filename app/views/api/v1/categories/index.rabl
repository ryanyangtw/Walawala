collection @categories ,:root => "categories"
#cache @categories
attributes :id, :title, :description


node(:href){|category| category_path(category)}
  
node :image do |category|
  {sqdefault: category.image.url(:mobile_sq_default), 
   mqdefault: category.image.url(:mobile_mq_default),
   hqdefault: category.image.url(:mobile_hq_default)}
end

node(:subscribed){|category| category.subscribers.exists?(current_user) ? 'true' : 'false'}

#child :programs do
#  attributes :id, :subject, :introduction
#  #node(:image_url){ |program| program.image_url }
#  #node(:href){|program| program_path(program)}
#end


