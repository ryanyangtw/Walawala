object @user 
#cache @user
attributes :id, :name, :email, :authentication_token

node :avatar do |user|
  {sqdefault: user.avatar.url(:mobile_sq_default), 
   mqdefault: user.avatar.url(:mobile_mq_default),
   hqdefault: user.avatar.url(:mobile_hq_default)}
end

node(:new_user){ |user| user.sign_in_count==1 ? 'true' : 'false'}