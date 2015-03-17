class AddGoogleAuthDataToUsers < ActiveRecord::Migration
  def change
    add_column :users, :google_auth_id, :string
    add_column :users, :google_auth_data, :text
  end
end
