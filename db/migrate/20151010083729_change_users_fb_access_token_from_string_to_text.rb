class ChangeUsersFbAccessTokenFromStringToText < ActiveRecord::Migration
  def change
    change_column :users, :fb_access_token, :text
  end
end
