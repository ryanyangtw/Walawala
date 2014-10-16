object @user 
cache @user
attributes :id, :name, :email, :authentication_token


node(:image_sqdefault){ |user| user.avatar.url(:mobile_sq_default)}
node(:image_mqdefault){ |user| user.avatar.url(:mobile_mq_default)}
node(:image_hqdefault){ |user| user.avatar.url(:mobile_hq_default)}
node(:new_user){ |user| user.sign_in_count==1 ? 'true' : 'false'}