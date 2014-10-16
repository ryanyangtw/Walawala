object @user => :user
attributes :name, :email

child :subscribed_programs do
  attributes :subject
  attributes :introduction
end

