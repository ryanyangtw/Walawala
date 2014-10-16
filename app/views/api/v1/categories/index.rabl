collection @categories ,:root => "categories"
cache @categories
attributes :id, :title, :description


node(:href){|category| category_path(category)}


child :programs do
  attributes :id, :subject, :introduction
  #node(:image_url){ |program| program.image_url }
  #node(:href){|program| program_path(program)}
end


