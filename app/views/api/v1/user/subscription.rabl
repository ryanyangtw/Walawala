object @user => :user
attributes :name, :email

child :subscriptions do
  attributes :subject
  attributes :introduction
end

