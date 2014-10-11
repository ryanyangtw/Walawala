class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :provider
      t.string :uid
      t.strimg :avatar
      t.string :authentication_token
      t.timestamps
    end
  end
end
